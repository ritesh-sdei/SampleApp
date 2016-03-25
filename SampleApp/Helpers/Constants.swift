//
//  Constants.swift
//  TestSwift
//
//  Created by Gurdev Singh on 12/22/14.
//  Copyright (c) 2014 Gurdev Singh. All rights reserved.
//
import UIKit

struct API {
    //https://ng-admin-staging.roadtohealth.co.uk/apis/insight_comparison_references/537f675a2140f60800de4531/1/20/true/en/55011efccfa6aed44311bb57
    ///apis/insight_comparison_references/" + hra + "/" + ethnicity + "/" + age + "/" + male + "/" + language + “
    static var UPLOAD_FOLDER="/uploads/hra/"
    static var UPLOAD_FOLDER_DIRECT="/uploads/"
    static var UPLOAD_PARENT="/"
    static var UPLOAD_PRODUCTS="/uploads/products/"
    static var UPLOAD_COACHES="/uploads/coaches/"
    static var UPLOAD_HELPER_FOLDER="/uploads/questions_helper/"
    
    static var BASE_URL:String = ""
    static var BASE_URL_DEV:String="https://ng-admin-dev.roadtohealth.co.uk"
//    static var BASE_URL_DEV:String="http://localhost:3000"
    
    static var BASE_URL_STAGING:String="https://ng-admin-staging.roadtohealth.co.uk"
    
    static var BASE_URL_LIVE:String="https://ng-admin-live.roadtohealth.co.uk"
    
    static var GA_TRACKING_ID : String="UA-3736123-27"
    static var GA_TRACKING_ID_LIVE : String="UA-3736123-30"
    static var GA_TRACKING_ID_STAGING : String="UA-3736123-27"
    
    static var API_INSIGHT = BASE_URL+"/apis/insight_comparison_references/"
    static var API_UPDATE_USER_PROFILE = BASE_URL+"/apis/put_user_profile/"
    static var API_FLAGS = BASE_URL + "/img/countries/"
    static var API_USER_LOGIN = BASE_URL + "/users/api/login"
    static var API_USER_REGISTER = BASE_URL + "/users/api/register"
    static var API_GET_USER_QUESTIONNAIRE_IDS = BASE_URL + "/apis/get_user_questionnaire_ids"
    static var API_GET_USER_QUESTIONNAIRE = BASE_URL + "/apis/get_user_questionnaire"
    static var API_GET_LANGUAGES = BASE_URL + "/apis/get_languages"
    static var API_GET_COUNTRY = BASE_URL + "/apis/countries"
    static var API_GET_POLICY = BASE_URL + "/apis/get_policy"
    static var API_GET_TERMS = BASE_URL + "/apis/get_terms"
    static var API_PUT_USER_DATA = BASE_URL + "/apis/put_user_data"
    static var API_GET_VARIABLES = BASE_URL + "/apis/get_variables"
    static var API_GET_CLIENTQUESTIONNAIRES = BASE_URL + "/apis/get_client_questionnaires_html"
    static var API_GET_QSUMMARYFORQUESTIONNAIRE = BASE_URL + "/apis/get_qsummaries"
    static var API_PUT_USER_PROFILE = BASE_URL + "/apis/put_user_profile"
    static var API_GET_USER_PHA = BASE_URL + "/apis/get_phas"
    static var API_GET_ACCESS_TOKEN = BASE_URL + "/oauth/token"
    static var API_FORGOTPASSWORD_REQUESTCODE = BASE_URL + "/apis/user/forgotpassword/requestCode"
    
    static var API_FORGOTPASSWORD =  BASE_URL + "/apis/user/forgotpassword"
    static var API_GETUSERTIMELINES =  BASE_URL + "/apis/get_user_timelines"
    
    static var API_Get_About =  BASE_URL +  "/apis/get_about"
    
    static var API_SOCIAL_LOGIN =  BASE_URL +  "/users/api/sociallogin"
    static var API_SOCIAL_REGISTER = BASE_URL + "/users/api/register/socialmedia"
    static var API_GET_FRIENDS_OF_Q = BASE_URL + "/apis/product/friends_of_q"
    static var API_POST_SAVE_PRODUCT_CATEGORIES = BASE_URL + "/apis/users/save_product_categories"
    static var API_SAVE_PRODUCT_LOG = BASE_URL + "/apis/product_log"
    static var API_GET_ALL_OBJECTIVES = BASE_URL + "/apis/get_all_objectives"
    static var API_GET_OBJECTIVE = BASE_URL + "/apis/get_objective"
    
    static var API_GET_DEACTIVATION_OPTIONS = BASE_URL + "/apis/get_deactivation"
    
    static var API_DEACTIVATE_PROFILE = BASE_URL + "/apis/users/deactivate_profile"
    
    static var API_GET_VERSION_DETAILS = BASE_URL + "/apis/get_latest_version"
    
    static var API_GET_COACHES = BASE_URL + "/apis/coaches/get_coaches"
    
    static var API_SAVE_COACH = BASE_URL + "/apis/users/save_coach"
    
    static var API_FETCH_USER = BASE_URL + "/apis/users/fetch_user"
    
    static var API_RECORD_USER_ACTIVITY = BASE_URL + "/users/api/record_user_activity"
    static var API_SAVE_USER_HEALTH_OBJECTIVE = BASE_URL + "/apis/save_user_health_objective"
    
    static var API_FIND_USER_HEALTH_OBJECTIVE = BASE_URL + "/apis/find_user_health_objective"
    
    static var API_DELETE_USER_HEALTH_OBJECTIVE = BASE_URL + "/apis/deleteObjectiveWithStrategies"
    
    static var API_GET_FACEBOOK_SHARE = BASE_URL + "/apis/get_facebook_share"
    
    static var API_GET_TWITTER_SHARE = BASE_URL + "/apis/get_twitter_share"
    
    static var API_GET_QUESTIONNAIRE_SCORE_HISTORY = BASE_URL + "/apis/score_history"
    
    static var API_GET_HEALTH_REPORT = BASE_URL + "/apis/downloadHealthReport"
    
    //apis/downloadHealthReport/<user_id>
    
}

struct COLORS {
//    static var COLOR_RED = UIColor(rgba: "#e5332a")
//    static var COLOR_GREEN = UIColor(rgba: "#76b72a")
//    static var COLOR_AMBER = UIColor(rgba: "#f29100")
}

struct SOCIALLOGINS {
    static var FACEBOOK = "facebook"
    static var TWITTER = "twitter"
}

struct APPDETAILS {
    static var ITUNES_STORE_URL = "https://itunes.apple.com/us/app/quealth-health-assessment/id1013837824?mt=8"
}


struct SHARING {
    static var CONTENT_DESCRIPTION = "I’ve just helped make the world healthier. Find out more..."
    static var CONTENT_TITLE = "Quealth – Life Changer!"
    static var CONTENT_URL = "https://www.quealth.co/healthierworld.html"
    static var IMAGE_URL = "https://ng-admin-live.roadtohealth.co.uk/img/icon.png"
}

struct DEVICES {
    enum enDeviceFamily:Int {
        case iPhone4S
        case iPhone5Family
        case iPhone6
        case iPhone6Plus
    }
    static var DEVICE : enDeviceFamily = enDeviceFamily.iPhone6Plus
}

struct SHARINGSCREEN {
    enum enScreen:Int {
        case HRA
        case PRODUCT
        case ABOUTUS
        case INSIGHTS
    }
}

struct CONNECTIONMODE {
    enum enBuildConnection:Int {
        case LIVE
        case Staging
        case Dev
    }
}

struct SHARINGMODE {
    enum enShareUsing:Int {
        case c
        case TWITTER
        case EMAIL
    }
}

struct TUTORIALKEYS {
    static var DASHBOARD_HRA_ICONS = "dashboard_hra_icons"
    static var DASHBOARD_LEFT_ICON = "dashboard_left_icon"
    static var DASHBOARD_RIGHT_ICON = "dashboard_right_icon"
    static var DASHBOARD_TIMELINES_AREA = "dashboard_timelines_area"
    static var DASHBOARD_SCORE_ICON = "dashboard_score_icon"
    static var DASHBOARD_HRA_BUTTON = "dashboard_hra_button"
    static var DASHBOARD_HRA_REDO_ICON = "dashboard_hra_redo_icon"
    static var DASHBOARD_GO_BUTTON = "dashboard_go_button"
    static var DASHBOARD_SWIPE_LEFT = "dashboard_swipe_left"
    static var DASHBOARD_SWIPE_RIGHT = "dashboard_swipe_right"
    static var DASHBOARD_OVERALL_SCORE = "dashboard_overall_score"
    static var DASHBOARD_HEALTH_REPORT = "dashboard_health_report"
    static var DASHBOARD_SOCIAL_SHARE = "dashboard_social_share"
    static var DASHBOARD_HEALTH_PLAN_BUTTON = "dashboard_hp_button"
    
    static var RESULTS_DOWN_ARROW = "results_down_arrow"
    
    static var INSIGHTS_SWIPE_TO_DASHBOARD = "insights_swipe_to_dashboard"
    static var INSIGHTS_RISK_BUTTONS = "insights_risk_buttons"
    
    static var PHAS_SWIPE_TO_DASHBOARD = "phas_swipe_to_dashboard"
    static var PHAS_UP_ARROW = "phas_up_arrow"
    static var PHAS_RISK_OVERALL_CELL = "phas_risk_overall_cell"
    static var PHAS_RISK_CELL = "phas_risk_cell"
    
    static var PHA_DETAIL_EXPAND_BUTTON = "pha_detail_expand_button"
    static var PHA_DETAIL_FOQ_BUTTON = "pha_detail_foq_button"
    
    static var HRA_HELP_ICON = "hra_help_icon"
    static var HRA_REDO = "hra_redo"
    
    static var HP_HELP_ICON = "hp_help_icon"
    static var HP_OBJECTIVE_CELL = "hp_objective_cell"
    static var HP_TARGET_CELL = "hp_target_cell"
    static var HP_STRATEGY_CELL = "hp_strategy_cell"
    static var HP_ADD_CUSTOM_STRATEGY_CELL = "hp_add_custom_strategy_cell"
    static var HP_EDIT_CUSTOM_STRATEGY_ICON = "hp_edit_custom_strategy_icon"
    static var HP_SET_TARGET_BUTTON = "hp_set_target_button"
}


struct SCREENS {
    static var SPLASH = "splash"
    static var ENTRY = "entry"
    static var LOG_IN = "log-in"
    static var REGISTER = "register"
    static var FORGOT_PASSWORD = "forgot-password"
    static var TERMS_CONDITIONS = "terms-and-conditions"
    static var PRIVACY_POLICY = "privacy-policy"
    static var DASHBOARD = "dashboard"
    static var WELCOME = "welcome"
    static var INSIGHT = "insights"
    static var SETTINGS = "settings"
    static var MAKE_WORLD_HEALTHIER = "tell-a-friend"
    static var DEVICE_SERVICES = "device-services"
    static var ABOUT = "about"
    static var LEGAL = "legal"
    static var PRODUCTS = "products"
    static var PRODUCTS_CATEGORIES = "products-categories"
    static var DEACTIVATE = "deactivate"
    static var RESULTS = " - qsummary"
    static var PHAS = " - pha"
    static var PHA_DETAIL = " - pha - "
    static var HRA = " - hra"
    static var HRA_QUESTION = " - hra - "
}

struct LOCAL_NOTIFICATIONS {
    static var NOTIFICATION_SHOW_DASHBOARD = "NOTIFICATION_SHOW_DASHBOARD"
    static var NOTIFICATION_CANCEL_HRA = "NOTIFICATION_CANCEL_HRA"
    static var NOTIFICATION_HIDE_HEADERBAR = "NOTIFICATION_HIDE_HEADERBAR"
    static var NOTIFICATION_SHOW_HEADERBAR = "NOTIFICATION_SHOW_HEADERBAR"
    static var NOTIFICATION_ACCESS_TOKEN_EXPIRED = "NOTIFICATION_ACCESS_TOKEN_EXPIRED"
}

struct ZENDESK_CREDENTIALS {
    //ZDKConfig.instance().initializeWithAppId("daf05ee05f66b1125b691e6aad386f183a26545c0eb1ac7f", 
    //zendeskUrl: "https://quealth.zendesk.com/", clientId: "mobile_sdk_client_63d34d05337e69c64c0f"
    
    static let APPID = "daf05ee05f66b1125b691e6aad386f183a26545c0eb1ac7f"
    static let CLIENTID = "mobile_sdk_client_63d34d05337e69c64c0f"
    static let URL = "https://quealth.zendesk.com/"
}

struct ZENDESK_TEST_CREDENTIALS {
    static let APPID = "daf05ee05f66b1125b691e6aad386f183a26545c0eb1ac7f"
    static let CLIENTID = "mobile_sdk_client_63d34d05337e69c64c0f"
    static let URL = "https://quealth.zendesk.com/"
}

