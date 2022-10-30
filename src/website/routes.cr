module Website
  ROUTES = Marten::Routing::Map.draw do
    path "/", HomeHandler, name: "home"
    path "/robots.txt", RobotsHandler, name: "robots"
    # path "/bad", BadHandler, name: "bad"
  end
end
