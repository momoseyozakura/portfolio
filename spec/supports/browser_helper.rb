module BrowserHelper
  def browser_size(width = 1080, height = 720)
    Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
  end
end
