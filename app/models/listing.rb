class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "no_img.png"
		validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	else
	has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "no_img.png", 
					  :storage => :dropbox,
    				  :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    				  :path => "style/:id_:filename"
    				  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    end
    validates :name, :description, :price, presence: true
    #There is an issue with the above validation. Need to figure it out
    validates :price, numericality: { greater_than: 0}
    validates_attachment_presence :image

    belongs_to :user
    has_many :orders
end

