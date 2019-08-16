## How to connect remote Wildfly https://ycat.top/post/wildfly/

1. run wildfly docker container.

    ```bash
    docker run -itd --rm -P -v /d/code/temp:/host wxdlong/wildfly:17
    ```
2. wait wildfly started.

    ```bash
    [root@1e531efb7792 wildfly-17.0.0.Final]# ss -atnp
    State       Recv-Q Send-Q          Local Address:Port        Peer Address:Port
    LISTEN      0      128                 127.0.0.1:8080                   *:*
    users:(("java",pid=69,fd=484))
    LISTEN      0      128                 127.0.0.1:8443                   *:*
    users:(("java",pid=69,fd=498))
    LISTEN      0      50                          *:9990                   *:*
    users:(("java",pid=69,fd=410))
    ```

3. Check the 9990 mapping port `docker ps ` is 32776
    ```bash
    $ docker ps
    CONTAINER ID        IMAGE                        COMMAND                  CREATED              STATUS              PORTS
                                                                    NAMES
    1e531efb7792        wxdlong/wildfly:standalone   "init.sh"                15 seconds ago       Up 14 seconds       0.0.0.0:32777->8080/tcp, 0.0.0.0:32776->9990/tcp, 0.0.0.0:32775->9999/tcp   compassionate_torvalds
    ```

4. Open web with url to login Wildfly managment with default userName `wxdlong` and pwd `12345678`

    http://127.0.0.1:32776/

5. Exceute bin/jconsole.bat by double click. 

    1. Input remote url `service:jmx:http-remoting-jmx://localhost:32776`
    2. Input UserName `wxdlong` & Pwd `12345678`
