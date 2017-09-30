# Canpe

Canpe is a template file repository, from which you can generate scaffold code to any projects.
If you write similar codes which is only slightly different, you can generate codes automatically.

## Installation

    $ gem install canpe

## Usage

Canpe stores template files as a repository. The default directory is `~/.canpe_repos`.

### Command

```
canpe g bootstrap_scaffold --class_name user --forms name:string age:integer birthday:datetime
```

### Repository Structure

For example, Like this.

```
.canpe_repos/
└── sample_scaffold
    ├── binding.rb
    └── templates
        └── app
            ├── controllers
            │   └── %pluralized_class_name%_controller.rb.erb
            └── views
                └── %pluralized_class_name%
                    ├── edit.html.erb.erb
                    ├── index.html.erb.erb
                    ├── new.html.erb.erb
                    └── show.html.erb.erb
```

Canpe is compatible with template engines like ERB, Slim, etc.
To modify the template, `Canpe.options` provides the parsed arguments.

```
<%%= form_with model: @<%= Canpe.options[:class_name] %> do |f| %>
  <% Canpe.options[:form].each do |pairs| %>
     <% column_name = pairs.first; column_type = pairs.last %>
     
     <% if column_type == 'integer' %>
       ...
     <% end %>
  <% end %>
<% end %>
```

If you want to customize the variables, you can create `binding.rb`.
In this file, you can validate inputs, set default values, define other variables.

```ruby

Canpe.define_binding do |b|
  b.validates :class_name, presence: true
  b.default :pluralize, true

  b.define_variable :class_name, b.options[:class_name], default: 'user'
  b.define_variable :pluralize_class_name, b.options[:class_name].pluralize
  b.define_variable :columns, b.options[:form]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ykosaka/canpe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Canpe project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/canpe/blob/master/CODE_OF_CONDUCT.md).
