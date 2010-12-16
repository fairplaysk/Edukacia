module ApplicationHelper
  def link_to_add_fields(name, f, association, index=5)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for association, new_object, :child_index => "new_#{association}" do |builder|
      "<fieldset class=\"#{association.to_s.singularize}_container\"><ol>".html_safe + render(association.to_s.singularize + "_fields", :f => builder, :index => index) + "</ol></fieldset>".html_safe
    end
    # link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")").html_safe)
    f.commit_button name, :button_html => {:name => 'add_placement_comment', :class => 'add_element', 'data-element' => "#{fields}", 'data-association' => association}
  end
end
