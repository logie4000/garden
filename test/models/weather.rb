require 'test_helper'
require 'mocha/minitest'
require 'weather'

class WeatherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "validating rest data" do
    mock_req = mock()
    mock_json = '{
  "response": {
    "version":"0.1",
    "termsofService":"http://www.wunderground.com/weather/api/d/terms.html",
    "features": {
    "history": 1
    }
  },
"history": {
  "dailysummary": [
    { "date": {
	"pretty": "12:00 PM EST on March 01, 2018",
	"year": "2018",
	"mon": "03",
	"mday": "01",
	"hour": "12",
	"min": "00",
	"tzname": "America/New_York"
     },
"fog":"0","rain":"1","snow":"0","snowfallm":"0.00", "snowfalli":"0.00","monthtodatesnowfallm":"", "monthtodatesnowfalli":"","since1julsnowfallm":"", "since1julsnowfalli":"","snowdepthm":"", "snowdepthi":"","hail":"0","thunder":"0","tornado":"0","meantempm":"7", "meantempi":"44","meandewptm":"1", "meandewpti":"34","meanpressurem":"1010", "meanpressurei":"29.82","meanwindspdm":"6", "meanwindspdi":"4","meanwdire":"","meanwdird":"42","meanvism":"16", "meanvisi":"10","humidity":"","maxtempm":"11", "maxtempi":"51","mintempm":"3", "mintempi":"37","maxhumidity":"93","minhumidity":"47","maxdewptm":"3", "maxdewpti":"38","mindewptm":"-3", "mindewpti":"26","maxpressurem":"1012", "maxpressurei":"29.89","minpressurem":"1004", "minpressurei":"29.65","maxwspdm":"24", "maxwspdi":"15","minwspdm":"0", "minwspdi":"0","maxvism":"16", "maxvisi":"10","minvism":"16", "minvisi":"10","gdegreedays":"0","heatingdegreedays":"21","coolingdegreedays":"0","precipm":"0.00", "precipi":"0.00","precipsource":"","heatingdegreedaysnormal":"","monthtodateheatingdegreedays":"","monthtodateheatingdegreedaysnormal":"","since1sepheatingdegreedays":"","since1sepheatingdegreedaysnormal":"","since1julheatingdegreedays":"","since1julheatingdegreedaysnormal":"","coolingdegreedaysnormal":"","monthtodatecoolingdegreedays":"","monthtodatecoolingdegreedaysnormal":"","since1sepcoolingdegreedays":"","since1sepcoolingdegreedaysnormal":"","since1jancoolingdegreedays":"","since1jancoolingdegreedaysnormal":"" }
  ]
}
}'

    expected = '{ "date": {
"pretty": "12:00 PM EST on March 01, 2018",
"year": "2018",
"mon": "03",
"mday": "01",
"hour": "12",
"min": "00",
"tzname": "America/New_York"
},
"fog":"0","rain":"1","snow":"0","snowfallm":"0.00", "snowfalli":"0.00","monthtodatesnowfallm":"", "monthtodatesnowfalli":"","since1julsnowfallm":"", "since1julsnowfalli":"","snowdepthm":"", "snowdepthi":"","hail":"0","thunder":"0","tornado":"0","meantempm":"7", "meantempi":"44","meandewptm":"1", "meandewpti":"34","meanpressurem":"1010", "meanpressurei":"29.82","meanwindspdm":"6", "meanwindspdi":"4","meanwdire":"","meanwdird":"42","meanvism":"16", "meanvisi":"10","humidity":"","maxtempm":"11", "maxtempi":"51","mintempm":"3", "mintempi":"37","maxhumidity":"93","minhumidity":"47","maxdewptm":"3", "maxdewpti":"38","mindewptm":"-3", "mindewpti":"26","maxpressurem":"1012", "maxpressurei":"29.89","minpressurem":"1004", "minpressurei":"29.65","maxwspdm":"24", "maxwspdi":"15","minwspdm":"0", "minwspdi":"0","maxvism":"16", "maxvisi":"10","minvism":"16", "minvisi":"10","gdegreedays":"0","heatingdegreedays":"21","coolingdegreedays":"0","precipm":"0.00", "precipi":"0.00","precipsource":"","heatingdegreedaysnormal":"","monthtodateheatingdegreedays":"","monthtodateheatingdegreedaysnormal":"","since1sepheatingdegreedays":"","since1sepheatingdegreedaysnormal":"","since1julheatingdegreedays":"","since1julheatingdegreedaysnormal":"","coolingdegreedaysnormal":"","monthtodatecoolingdegreedays":"","monthtodatecoolingdegreedaysnormal":"","since1sepcoolingdegreedays":"","since1sepcoolingdegreedaysnormal":"","since1jancoolingdegreedays":"","since1jancoolingdegreedaysnormal":"" }'

    RestClient::Request.stubs(:new).returns(mock_req)
    mock_req.stubs(:execute).returns(mock_json)

    result = Weather.get_date_summary("2018-03-01", "Williamstown", "MA")
    
    assert_equal JSON.parse(expected), result
  end

  test "generate correct history url" do
    result = Weather.generate_history_url("2018-03-02", "Williamstown", "MA")
    expected = "history_20180302/q/MA/Williamstown.json"

    assert_equal expected, result
  end
end
