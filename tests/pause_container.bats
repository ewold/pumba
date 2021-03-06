@test "Should pause running container" {
    # given (started container)
    docker run -d --name pausing_victim alpine tail -f /dev/null

    # when (trying to pause container)
    run pumba pause --duration 3s pausing_victim &
    sleep 2

    # then (container has been paused)
    run bash -c "docker inspect pausing_victim | grep Paused"
    [[ $output == *"true"* ]]

    # and (container has been unpaused)
    sleep 4
    run bash -c "docker inspect pausing_victim | grep Paused"
    [[ $output == *"false"* ]]

    # cleanup
    docker rm -f pausing_victim || true
}