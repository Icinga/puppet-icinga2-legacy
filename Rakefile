require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'

if not ENV['SPEC_OPTS']
  ENV['SPEC_OPTS'] = '--format documentation'
end

#PuppetLint.configuration.send('disable_documentation')
#PuppetLint.configuration.send('disable_single_quote_string_with_variables')

PuppetSyntax.exclude_paths = [ "vendor/**/*.*" ]
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp", "vendor/**/*.pp"]

# Alternative configuration until https://github.com/rodjek/puppet-lint/pull/397 gets merged
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = PuppetLint.configuration.ignore_paths
end

task :all => [ :validate, :metadata, :lint, :spec ]
