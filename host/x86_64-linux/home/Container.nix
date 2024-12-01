{ ... }: {
	container = {
		enable      = true;
		autoStart   = true;
		domain      = "voronind.com";
		host        = "188.242.247.132";
		interface   = "enp8s0";
		localAccess = "10.0.0.0/24";
		storage     = "/storage/hot/container";
		module = {
			change.enable   = true;
			cloud.enable    = true;
			ddns.enable     = true;
			dns.enable      = true;
			download.enable = true;
			frkn.enable     = true;
			git.enable      = true;
			home.enable     = true;
			iot.enable      = true;
			jobber.enable   = true;
			mail.enable     = true;
			office.enable   = true;
			paper.enable    = true;
			pass.enable     = true;
			paste.enable    = true;
			postgres.enable = true;
			print.enable    = true;
			proxy.enable    = true;
			rabbitmq.enable = true;
			read.enable     = true;
			redis.enable    = true;
			search.enable   = true;
			status.enable   = true;
			stock.enable    = true;
			terraria.enable = true;
			vpn.enable      = true;
			watch.enable    = true;
			yt.enable       = true;
		};
		media = {
			anime = [
				"/storage/cold_1/anime"
				"/storage/cold_2/anime"
			];
			book = [
				"/storage/hot/book"
			];
			download = [
				"/storage/hot/download"
			];
			manga = [
				"/storage/cold_1/manga"
				"/storage/cold_2/manga"
			];
			movie = [
				"/storage/cold_1/movie"
				"/storage/cold_2/movie"
			];
			music = [
				"/storage/cold_2/music"
			];
			paper = [
				"/storage/hot/paper"
			];
			porn = [
				"/storage/cold_2/porn"
			];
			photo = [
				"/storage/hot/container/cloud/data/data/cakee/files/photo"
				"/storage/cold_1/backup/tmp/photo"
			];
			show = [
				"/storage/cold_1/show"
				"/storage/cold_2/show"
			];
			study = [
				"/storage/cold_1/study"
				"/storage/cold_2/study"
			];
			work = [
				"/storage/cold_2/work"
			];
			youtube = [
				"/storage/cold_1/youtube"
				"/storage/cold_2/youtube"
			];
		};
	};
}
