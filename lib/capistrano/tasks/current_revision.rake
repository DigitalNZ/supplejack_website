desc "Shows the currently deployed branch for the stage"
task :current_revision do
  on roles(:app) do
    deployed_revision = capture("cd #{deploy_to}; cat revisions.log | tail -n 1")

    p deployed_revision
  end
end
