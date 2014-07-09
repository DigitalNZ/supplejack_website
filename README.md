# Supplejack Website

This website demo is part of the standard Supplejack platform that can aggregate data and content from many different sources.

It uses the `supplejack_client` gem to connect to the Supplejack API. For more information about Supplejack Client gem, please refer to the [documentation](http://digitalnz.github.io/supplejack/start/supplejack-client.html)

## Installation

Clone the project

```bash
git clone git@github.com:DigitalNZ/supplejack_website.git
```

Create a `local_env.rb` file and place it inside `config/`

```ruby
# config/local_env.rb
API_HOST = 'http://localhost:3000'
API_KEY = 'your_api_key'
THUMBNAIL_SERVER_URL = 'http://thumbnails.digitalnz.org'
```

Run bundle install

```bash
bundle install
```

Run Rails server

```bash
rails s
```

## COPYRIGHT AND LICENSING  

### MAJORITY OF SUPPLEJACK CODE - GNU GENERAL PUBLIC LICENCE, VERSION 3  

Supplejack is a tool for aggregating, searching and sharing metadata records. Supplejack Website is a component of Supplejack. Except as indicated below, the Supplejack Website code at https://github.com/DigitalNZ/supplejack_website is Crown copyright (C) 2014, New Zealand Government. Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. http://digitalnz.org/supplejack

Except as indicated below, this program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.   

This program is distributed in the hope that it will be useful, but WITHOUT ANY 
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses / http://www.gnu.org/licenses/gpl-3.0.txt  

#### MASONRY
The JavaScript grid layout library by David DeSandro (see http://masonry.desandro.com/#mit-license) is licensed under the MIT license (see http://desandro.mit-license.org) 

#### INFINITE SCROLL
The jQuery plugin for infinite scrolling by Paul Irish (see https://github.com/paulirish/infinite-scroll) is licensed under the MIT license (see https://github.com/paulirish/infinite-scroll#license) 

#### NORMALIZE.CSS
The customizable CSS file, that makes browsers render all elements more consistently, by Nicolas Gallagher and Jonathan Neal (see https://github.com/necolas/normalize.css) is licensed under terms at https://github.com/necolas/normalize.css/blob/master/LICENSE.md 