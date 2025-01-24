resource "google_monitoring_alert_policy" "test_policy" {
  display_name = "test policy"
  documentation {
    subject = "test"
  }
  user_labels = {}

  conditions {
    display_name = "Cloud Router - BGP session status change"
    condition_threshold {
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }
      comparison    = "COMPARISON_GT"
      duration      = "0s"
      filter        = "resource.type = \"gce_router\" AND metric.type = \"router.googleapis.com/bgp/session_up\" AND metric.labels.bgp_peer_name = \"new-bgp\""
      threshold_value = 0.5
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "1800s"
    notification_prompts = ["OPENED", "CLOSED"]
  }

  combiner                = "OR"
  enabled                 = true
  notification_channels   = ["projects/decent-tape-416310/notificationChannels/8487441449588706880"]
  severity                = "CRITICAL"

  creation_record {
    mutate_time = "2025-01-23T18:00:29.087679611Z"
    mutated_by  = "Arunkumar.Veerapandian@gmail.com"
  }

#   mutation_record {
#     mutate_time = "2025-01-23T18:00:29.087679611Z"
#     mutated_by  = "Arunkumar.Veerapandian@gmail.com"
#   }
}


resource "google_monitoring_alert_policy" "bgp_status_change_vpn" {
  display_name = "BGP status change - VPN remote-0 - DITC-NPRD to CoreSvcNPRD"
  documentation {
    content  = <<-EOT
      ### VPN tunnel between DITC NPRD and Core Services NPRD projects

      **FROM:**  
      project: datacenter-in-the-cloud9b856e0  
      router: dtic-nprd-inside-vpn-ue4-cr  
      gateway: dtic-nprd-inside-vpn-gw-ue4  
      tunnel: dtic-remote-0  
      region: US-East4  

      **TO:**  
      project: nprd-ensono-core-services277f8  
      router: nonprod-core-services-vpc-ue4-cr  
      gateway: nonprod-core-services-vpc-gw-ue4  
      tunnel: nonprod-core-services-vpc-remote-0  
      region: US-East4  
    EOT
    mime_type = "text/markdown"
    subject   = "BGP status change on VPN tunnel - DITC-NPRD to CoreSvcNPRD"
  }
  user_labels = {}

  conditions {
    display_name = "Cloud Router - BGP session status change"
    condition_threshold {
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
      }
      comparison    = "COMPARISON_LT"
      duration      = "0s"
      filter        = "resource.type = \"gce_router\" AND metric.type = \"router.googleapis.com/bgp/session_up\" AND metric.labels.bgp_peer_name = \"dtic-remote-0\""
      threshold_value = 0.5
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close          = "3600s"
    notification_prompts = ["OPENED", "CLOSED"]
  }

  combiner              = "OR"
  enabled               = true
  notification_channels = ["projects/datacenter-in-the-cloud9b856e0/notificationChannels/7106489968635158314"]
  severity              = "CRITICAL"

  creation_record {
    mutate_time = "2024-09-10T18:37:04.907135156Z"
    mutated_by  = "armatowskit@dnb.com"
  }

#   mutation_record {
#     mutate_time = "2024-09-10T19:25:35.878561062Z"
#     mutated_by  = "armatowskit@dnb.com"
#   }
}
