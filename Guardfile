# A sample Guardfile
# More info at https://github.com/guard/guard#readme
interactor :simple

guard 'rspec', all_after_pass: false do
  watch('spec/spec_helper.rb')  { "spec" }
  watch('config/routes.rb')     { "spec" }
  watch(%r{^(spec/.+_spec\.rb)$})                   { |m| "#{m[1]}" }
  watch(%r{^app/models/(.+)\.rb$})                  { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$})  { |m| "spec/controllers/#{m[1]}_controller_spec.rb" }
end

