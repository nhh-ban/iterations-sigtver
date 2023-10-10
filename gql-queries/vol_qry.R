vol_qry <-
  function(id, from, to){
    glue::glue(
      '
        {
          trafficData(trafficRegistrationPointId: "<<id>>") {
            volume {
              byHour(from: "<<from>>", to: "<<to>>") {
                edges {
                  node {
                    from
                    to
                    total {
                      volumeNumbers {
                        volume
                      }
                    }
                  }
                }
              }
            }
          }
        }
      ',
      .open="<<",
      .close=">>"
    )
  }
