# -*- encoding : utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

contact_address = <<eos
<h3>Aliancia Fair-play</h3>
Západný rad 39
<br>
811 04 Bratislava
<p>tel./fax: +421 2 5564 0131<br />mobil: +421 911 724 189</p>

<p>
  email:
  <script type='text/javascript'>
    <!-- protected email script by Joe Maller -->
    <!-- JavaScripts available at http://www.joemaller.com -->
    <!-- this script is free to use and distribute -->
    <!-- but please credit me and/or link to my site -->
    emailE=('kvizy@' + 'fair-play.sk');
    document.write('<A href="mailto:' + emailE + '">' + emailE + '</a>');
  </script>
  <noscript>
    <em></em>
    Email address protected by JavaScript.
    <br>
    Please enable JavaScript to contact me.
  </noscript>
  <br>
  <a href='http://www.fair-play.sk' target='_blank'>www.fair-play.sk</a>
</p>
<p>

  <br>
  <h3>Iné projekty Aliancie Fair-play</h3>
  <br>
  <a href='http://www.datanest.sk' target='_blank'>www.datanest.sk</a>
  <br>
  <a href='http://www.politikaopen.sk' target='_blank'>www.politikaopen.sk</a>
  <br>

  <a href='http://www.bielavrana.sk' target='_blank'>www.bielavrana.sk</a>
</p>
eos

User.find(:first, :conditions => {:username => 'admin', :email => 'admin@kwizzer.sk'}) || User.create(:username => 'admin', :password => 'changeme', :email => 'admin@kwizzer.sk', :super => true)

Label.find_or_create_by_identifier_and_content_and_language('about', '<p>Lorem ipsum.</p><p>Lorem ipsum.</p><p>Lorem ipsum.</p>', 'en')
Label.find_or_create_by_identifier_and_content_and_language('about', '<p>Lorem ipsum.</p><p>Lorem ipsum.</p><p>Lorem ipsum.</p>', 'sk')
Label.find_or_create_by_identifier_and_content_and_language('contact', contact_address, 'en')
Label.find_or_create_by_identifier_and_content_and_language('contact', contact_address, 'sk')
Label.find_or_create_by_identifier_and_content_and_language('header', 'Maecenas metus lorem, porta porttitor rutrum vel, euismod vitae risus. Integer molestie arcu sed eros iaculis faucibus vitae at dui. Duis pulvinar lectus nec libero rutrum viverra. Donec dictum pretium luctus. Fusce viverra suscipit nunc in viverra.', 'sk')
Label.find_or_create_by_identifier_and_content_and_language('header', 'Maecenas metus lorem, porta porttitor rutrum vel, euismod vitae risus. Integer molestie arcu sed eros iaculis faucibus vitae at dui. Duis pulvinar lectus nec libero rutrum viverra. Donec dictum pretium luctus. Fusce viverra suscipit nunc in viverra.', 'en')
Label.find_or_create_by_identifier_and_content_and_language('footer', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec orci in odio consectetur laoreet vitae in nibh. Morbi in vehicula tellus. Cras ultrices rhoncus lacus, interdum cursus sapien volutpat aliquam. Vivamus viverra dui et leo congue pharetra elementum felis vestibulum.', 'sk')
Label.find_or_create_by_identifier_and_content_and_language('footer', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec orci in odio consectetur laoreet vitae in nibh. Morbi in vehicula tellus. Cras ultrices rhoncus lacus, interdum cursus sapien volutpat aliquam. Vivamus viverra dui et leo congue pharetra elementum felis vestibulum.', 'en')