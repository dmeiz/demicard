class Demicard < Thor
  desc 'rsync_to_stage', 'Rsync current directory to stage server to avoid cap deploys'
  def rsync_to_stage
    system %q(rsync -av -e 'ssh -p 2222' --exclude .git . deployer@localhost:/u/apps/demicard/current)
  end
end
