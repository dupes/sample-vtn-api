![](nebland_oadr_logo.svg)
---
**Benjamin DuPont**  
ben@nebland.com  
[https://oadrservices.com](https://oadrservices.com)

*API Date:* **2016-02-11**

# OADR VTN API Requests & Responses


## General Response Body Structure

```json
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

```json
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

## Available Requests

### Create Event
Method: `POST`
URL: `/api/manage_event/create`
Request Body (JSON):
```json
{
  "dtstart_str": "2015-09-17 12:30:00",
  "market_context": "TestMarketContext",
  "duration": 5,
  "priority": 1,
  "response_required_type": "always",
  "signal_name": "simple",
  "signal_type": "delta",
  "payload": "1.0",
  "targets": [
    {
      "type": "group",
      "identifier": "TestGroup"
    },
    {
      "type": "ven",
      "identifier": "9b7b7e91ccf7244455c3"
    }
  ]  
}
```

Response Body Result Object (JSON):
```json
{
  "event_id": "4b2c013ff071a2504e40"
}
```
***

### Publish Event
Method: `POST`
URL: `/api/manage_event/publish`
Request Body (JSON):
```json
{
  "event_id": "4b2c013ff071a2504e40"
}
```

Response Body Result Object (JSON):
```json
{
  "published": true
}
```

***

### Create Schedule
Method: `POST`
URL: `/api/manage_event/create_schedule`
Request Body (JSON):
```json
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
```json
{
  "event_id": "627268ec736c8ebe302b"
}
```

***

### Get Event Info
Method: `POST`
URL: `/api/manage_event/info`
Request Body (JSON):
```json
{
  "event_id": "4b2c013ff071a2504e40"
}
```

Response Body Result Object (JSON):
```json
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
```json
{
  "ven": "TestVEN"
}
```

Response Body Result Object (JSON):
```json
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

***

### Get VEN Status
Method: `POST`
URL: `/api/manage_ven/status`
Request Body (JSON):
```json
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

Response Body Result Object (JSON):
```json
{
  "status": "offline"
}
```

***

### Get VEN LastCommTime
Method: `POST`
URL: `/api/manage_ven/last_comm_time`
Request Body (JSON):
```json
{
  "ven_id": "9b7b7e91ccf7244455c3"
}
```

Response Body Result Object (JSON):
```json
{
  "last_comm_time": "2015-09-15T21:11:56Z"
}
```

***
