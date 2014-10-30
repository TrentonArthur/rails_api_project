Rails.application.routes.draw do
  get("/", { :controller => "pages", :action => "home" })

  get("/weather/:address", { :controller => "weather", :action => "location" })
end
