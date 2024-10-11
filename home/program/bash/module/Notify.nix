{ ... }:
{
  text = ''
    # Send Telegram notification.
    # Usage: notify <MESSAGE>
    function notify() {
      curl -X POST -H 'Content-Type: Application/json' -d "{\"chat_id\":\"155897358\",\"text\":\"$1\"}" https://api.telegram.org/bot2046849441:AAHQpjRK4xpL8tEUyN4JTSDUUze4J0wSIy4/sendMessage &> /dev/null
    }

    # Send silent Telegram notification.
    # Usage: notify_silent <MESSAGE>
    function notify_silent() {
      curl -X POST -H 'Content-Type: Application/json' -d "{\"chat_id\":\"155897358\",\"text\":\"$1\",\"disable_notification\":\"true\"}" https://api.telegram.org/bot2046849441:AAHQpjRK4xpL8tEUyN4JTSDUUze4J0wSIy4/sendMessage &> /dev/null
    }
  '';
}
