module ApplicationHelper

  def urls_to_book(s)
   # s.gsub! (/\s(http:\/\/.*?\.(png|jpg))\s/),
   #         '<p><img src="\1"/></p>'

     s.delete "books", "notes"
    s.html_safe
  end

end
