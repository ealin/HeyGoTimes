def hot_news_rank_reduction (m,sleep_period)

    while true

        command = 'http://www.heygotimes.com/api/news_rank_reduction'
        m.synchronize {
            puts 'Auto rank reduction...\n'
            open(command)
        }

        sleep(sleep_period)
    end
end
