module DeviseHelper
  def devise_error_messages!
       messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join

   html = <<-HTML
   <div class="alert-error">
     #{messages}
   </div>
   HTML

   html.html_safe
  end
end