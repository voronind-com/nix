{ ... }: {
	container = {
		enable = true;

		module = {
			change.enable   = true;
			cloud.enable    = true;
			ddns.enable     = true;
			dns.enable      = true;
			download.enable = true;
			git.enable      = true;
			# ISSUE: hdd.enable      = true;
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
			vpn.enable      = true;
			watch.enable    = true;
			yt.enable       = true;
			zapret.enable   = true;
		};

		storage     = "/storage/hot/container";
		domain      = "voronind.com";
		host        = "188.242.247.132";
		interface   = "enp8s0";
		localAccess = "10.0.0.0/24";
		media = {
			anime    = [ "/storage/cold_1/media/anime" "/storage/cold_2/media/anime" ];
			book     = [ "/storage/hot/media/book" ];
			download = [ "/storage/hot/download" ];
			manga    = [ "/storage/cold_1/media/manga" "/storage/cold_2/media/manga" ];
			movie    = [ "/storage/cold_1/media/movie" "/storage/cold_2/media/movie" ];
			music    = [ "/storage/cold_2/media/music" "/storage/hot/media/music" ];
			paper    = [ "/storage/hot/media/paper" ];
			porn     = [ "/storage/cold_2/media/porn" ];
			photo    = [ "/storage/hot/container/cloud/data/data/cakee/files/media/photo" "/storage/cold_1/backup/tmp/photo" ];
			show     = [ "/storage/cold_1/media/show" "/storage/cold_2/media/show" ];
			study    = [ "/storage/cold_1/media/study" "/storage/cold_2/media/study" ];
			work     = [ "/storage/cold_2/media/work" ];
			youtube  = [ "/storage/cold_1/media/youtube" "/storage/cold_2/media/youtube" ];
		};
	};
}
