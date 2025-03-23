{ ... }:
let
  bookmarks = [ (mkBookmark "Dashboard" "https://home.voronind.com") ];

  mkBookmark = name: url: { inherit name url; };
in
{
  policies.ManagedBookmarks = [ { toplevel_name = "Pin"; } ] ++ bookmarks;
}
