class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]

  def show; end

  def result; end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    response = service.call

    gist_url = response.html_url
    gist_link = view_context.link_to(gist_url, gist_url, target: :blank)

    if service.status_ok?
      create_gist!(gist_url)
      flash[:notice] = t('.success', url: gist_link)
    else
      flash[:alert] = t('.failed')
    end

    redirect_to @test_passage
  end

  def update
    if params[:answer_ids].nil?
      redirect_to result_test_passage_path(@test_passage)
    else
      @test_passage.accept!(params[:answer_ids])
      if @test_passage.completed?
        awarded_badges! if @test_passage.test_passed?

        TestsMailer.completed_test(@test_passage).deliver_now
        redirect_to result_test_passage_path(@test_passage)
      else
        render :show
      end
    end
  end


  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def create_gist!(gist_url)
    current_user.gists.create(question: @test_passage.current_question, url: gist_url)
  end

  def awarded_badges!
    badge_service = BadgeService.new(@test_passage)
    badge_service.awarded_badges!
    current_user.badges.push(badge_service.badges)
  end
end
