require "rails_helper"

describe "A visitor" do
  it "cannot see classroom tutorials if not logged in" do
    prework_tutorial_data = {
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>true,
    }

    prework_tutorial = Tutorial.create! prework_tutorial_data

    prework_tutorial.videos.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
    "position"=>1 })

    mod_1_tutorial_data = {
      "title"=>"Back End Engineering - Module 1",
      "description"=>"Videos related to Mod 1.",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
      "classroom"=>true,
    }

    m1_tutorial = Tutorial.create! mod_1_tutorial_data

    m1_tutorial.videos.create!({
      "title"=>"Flow Control in Ruby",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"tZDBWXZzLPk",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "position"=>1 })

    mod_3_tutorial_data = {
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>false,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    }
    m3_tutorial = Tutorial.create! mod_3_tutorial_data

    m3_tutorial.videos.create!({
      "title"=>"Customizing JSON in your API",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"cv1VQ_9OqvE",
      "thumbnail"=>"https://i.ytimg.com/vi/cv1VQ_9OqvE/hqdefault.jpg",
      "position"=>1
    })

    visit "/"

    expect(page).to_not have_content("Back End Engineering - Prework")
    expect(page).to_not have_content("Back End Engineering - Module 1")
    expect(page).to have_content("Back End Engineering - Module 3")
  end

  it "cannot visit a classroom tutorial show page if not logged in" do
    prework_tutorial_data = {
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>true,
    }

    prework_tutorial = Tutorial.create! prework_tutorial_data

    prework_tutorial.videos.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
    "position"=>1 })

    visit tutorial_path(prework_tutorial)

    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
