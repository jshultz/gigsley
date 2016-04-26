class Photo < ActiveRecord::Base

  belongs_to :gallery

  has_attached_file :image,
                    path: ":rails_root/public/images/:id/:filename",
                    url: "/images/:id/:filename",
                    styles: {
                      small:  '150x150>',
                      medium: '600X600>'
                    }

  do_not_validate_attachment_file_type :image

end