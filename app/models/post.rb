class Post < ActiveRecord::Base
  include PublicActivity::Model
  
  belongs_to :user
  validates_presence_of :content
  auto_html_for :content do
    html_escape
    image(:width => 500, :height => 300)
    youtube(:width => 500, :height => 300)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
