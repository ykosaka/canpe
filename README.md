# Canpe

Canpe is a template-based file generator.

## Installation

    $ gem install canpe

## Usage

When run the `canpe create sample_repository`, canpe initialize new repo in the current directory.

```
$ canpe create sample_repository
create directory: ./.canpe_repos/sample_repository/templates
copy ./.canpe_repos/sample_repository/binding.yml
```

`binding.yml` defines the variables which you can access from templates.

```
variables:
- name: sample_variable
  type: string
- name: sample_array
  type: array
``` 

Set your template files under the templates directory.
Each file is automatically evaluated as ERB template.

```
<%= canpe[:sample_variable] %>
<%= canpe[:sample_array].join ', ' %>
``` 

Then run `canpe generate sample_repository`.

```
$ bundle exec bin/canpe generate sample_repository
working directory (/Users/Yoshinori/gem_projects/canpe) ? 
you need to set variables to generate codes!
1: sample_variable (string) 
2: sample_array (array) 

If you want to stop setting array, let it blank and press enter.
sample_variable ?) Hello, world
sample_array[0] ?) 1
sample_array[1] ?) 2
sample_array[2] ?) 3
sample_array[3] ?) 
finished variable settings: {"sample_variable"=>"Hello, world", "sample_array"=>["1", "2", "3"]}
copy: /Users/Yoshinori/gem_projects/canpe/hello

```

If you set sample_variable as 'Hello, world', and sample_array as [1, 2, 3],
This template is rendered like this.

```
Hello, world
1, 2, 3
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
