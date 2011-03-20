module ApplicationHelper
  def link_to_add_fields(name, f, association, subassociation = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    (1..subassociation[1]).each { new_object.send(subassociation[0]).build } if subassociation.present?
    
    fields = f.fields_for association, new_object, :child_index => "new_#{association}" do |builder|
      "<fieldset class=\"#{association.to_s.singularize}_container\"><ol>".html_safe + render(association.to_s.singularize + "_fields", :f => builder, :index => 5) + "</ol></fieldset>".html_safe
    end
    f.commit_button name, :button_html => {:name => "add_#{association.to_s.singularize}", :class => 'add_element', 'data-element' => "#{fields}", 'data-association' => association}
  end
  
  def facebook_link_to(submission)
    "http://www.facebook.com/sharer.php?u=#{submission_url(submission)}&t=#{submission.quiz.name} @ kvizy.fair-play.sk"
  end
  
  def twitter_link_to(submission)
    "http://twitter.com/share?url=#{submission_url(submission)}&text=#{submission.quiz.name} @ kvizy.fair-play.sk"
  end
end
