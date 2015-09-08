# Supplejack Website

[![Build Status](https://travis-ci.org/DigitalNZ/supplejack_website.svg?branch=master)](https://travis-ci.org/DigitalNZ/supplejack_website)

This website demo is part of the standard Supplejack platform that can aggregate data and content from many different sources.

It uses the `supplejack_client` gem to connect to the Supplejack API. For more information about Supplejack Client gem, please refer to the [documentation](http://digitalnz.github.io/supplejack/start/supplejack-client.html).

You can install Rails 3.2, Rails 4.1 or Rails 4.2 to run this website. Please do not use any Rails version
 higher than 4.2.

:warning: **It is very important that you have setup an API instance with correct record schema before setting up this project(or any projects that interact with the API). The most important component of the API is record schema. Refer to [API docs](http://digitalnz.github.io/supplejack/api/creating-schemas.html) for instruction.**

## Installation

Start API server on port 3000

```bash
rails s
```

Clone the demo website project

```bash
git clone git@github.com:DigitalNZ/supplejack_website.git
```

Create a `local_env.rb` file and place it inside `config/`

```ruby
# config/local_env.rb
API_HOST = 'http://localhost:3000'
API_KEY = 'your_api_key'
THUMBNAIL_SERVER_URL = "http://magickly.afeld.me/"
```
To generate api key, please refer to [API Docs](http://digitalnz.github.io/supplejack/start/supplejack-api.html).

Run `bundle install`

```bash
bundle install
```

Run Rails server

```bash
rails s -p 3001
```

:warning: This demo website has been configured to work with sample record schema that comes with supplejack api. It should work fine without any modification. If you want customization, please refer to **Configuration** section to know how to do.

## Configuration

To interact with supplejack_api, you need to configure `supplejack_client.rb` file.

Open `config/initializers/supplejack_client.rb`

You **must** update these options for customization:

* **api_key**  
* **api_url**
* **facets**: List of available facets from the api that you want to be show in the website. They must be defined in record schema. Refer to [API docs](http://digitalnz.github.io/supplejack/api/creating-schemas.html) to understand how facet is defined.
* **fields**: List of fields that you want to be requested to the API for every record. They must be defined in record schema. You can also include group in the list.
Please refer to [API docs](http://digitalnz.github.io/supplejack/api/creating-schemas.html) to know how to define group.
* **search_attributes**: List of fields to be sent to search object. These fields must be defined in record schema.
* **enable_debugging**: Turn on full logging, default to true.
* **enable_caching**: Enable caching long api request, default to false.

Other commented fields can be left with their default values.

## Notes

You need to set up thumbnailer server for image processing(**THUMBNAIL_SERVER_URL** setting in *local_env.rb* file). Check out [Magickly](https://github.com/afeld/magickly) on how to set up an image manipulation service.

For the purpose of demo, you can use the existing [Magickly](http://magickly.afeld.me/) instance.  
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
