![](nebland_oadr_services_logo.png)
# OADR VTN API Requests & Responses
**2015-09-17**

## General Response Body Structure

```
# Success
{
  "response": {
    "status": {
      "code": "success",
      "http_code": 200,
      "error_message": null
    },
    "result": <JSON_OBJECT>
  }
}
```

```
# Failure
{
  "response": {
    "status": {
      "code": "failure",
      "http_code": 500,
      "error_message": <ERROR_MESSAGE_STRING>
    },
    "result": null
  }
}
```
***
***

## Available Requests

### Create Event 
Method: `POST`
URL: `/api/manage_event/create`
Request Body (JSON):
```
{
  "dtstart_str": "2015-09-17 12:30:00",
  "market_context": "TestMarketContext",
  "duration": 5,
  "priority": 1,
  "response_required_type": "always",
  "signal_name": "simple",
  "signal_type": "delta",
  "group": "TestGroup",
  "payload": "1.0"
}
```

Response Body Result Object (JSON):
```
{
  "event_id": "4b2c013ff071a2504e40"
}
```
***

### Publish Event
Method: `POST`
URL: `/api/manage_event/publish`
Request Body (JSON):
```
{
  "event_id": "4b2c013ff071a2504e40"
}
```

Response Body Result Object (JSON):
```
{
  "published": true
}
```

***

### Create Schedule
Method: `POST`
URL: `/api/manage_event/create_schedule`
Request Body (JSON):
```
{
  "start_date": "2015-10-01",
  "end_date": "2015-10-31",
  "start_time_str": "14:30",
  "signal_name": "simple",
  "signal_type": "delta",
  "payload": "1.6",
  "targets": [
    {
      "type": "group",
      "identifier": "TestGroup"
    },
    {
      "type": "ven",
      "identifier": "9b7b7e91ccf7244455c3"
    }
  ],
  "event": {
    "duration": 45,
    "market_context": "TestMarketContext",
    "priority": 1,
    "response_required_type": "always"
  }
}
```

Response Body Result Object (JSON):
```
{
  "event_id": "627268ec736c8ebe302b"
}
```

***

### Get Event Info
Method: `POST`
URL: `/api/manage_event/info`
Request Body (JSON):
```
{
  "event_id": "4b2c013ff071a2504e40"
}
```

Response Body Result Object (JSON):
```
{
  "event": {
    "event_id": "4b2c013ff071a2504e40",
    "modification_number": 1,
    "priority": 1,
    "test_event": "false",
    "vtn_comment": null,
    "dtstart": "2015-09-17T12:30:00Z",
    "duration": 5,
    "tolerance": 0,
    "ei_notification": 0,
    "ei_rampup": 0,
    "ei_recovery": 0,
    "created_at": "2015-09-17T15:52:09Z",
    "updated_at": "2015-09-17T15:53:11Z",
    "template": null,
    "published": true,
    "market_context": "TestMarketContext",
    "event_status": "far",
    "response_required_type": "always"
  }
}
```

***

### Get VEN VenID
Method: `POST`
URL: `/api/manage_ven/ven_id`
Request Body (JSON):
```
{
  "ven": "TestVEN"
}
```

Response Body Result Object (JSON):
```
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

***

### Get VEN Status
Method: `POST`
URL: `/api/manage_ven/status`
Request Body (JSON):
```
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

Response Body Result Object (JSON):
```
{
  "status": "offline"
}
```

***

### Get VEN LastCommTime
Method: `POST`
URL: `/api/manage_ven/last_comm_time`
Request Body (JSON):
```
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

Response Body Result Object (JSON):
```
{
  "last_comm_time": "2015-09-15T21:11:56Z"
}
```

***
