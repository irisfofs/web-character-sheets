describe "IndexController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController =(keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      # capture the injected service
      httpBackend = $httpBackend

      if results
        request = new RegExp("\/sheets.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('IndexController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("webCharacterSheets"))
  beforeEach(setupController())

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())

      it 'defaults to no recipes', ->
        expect(scope.characters).toEqualData([])

  describe 'with keywords', ->
    keywords = 'foo'
    characters = [
      {
        name: 'Baked Potatoes'
      },
      {
        name: 'Potatoes Au Gratin'
      }
    ]
    beforeEach ->
      setupController(keywords,characters)
      httpBackend.flush()

    it 'calls the back-end', ->
      expect(scope.characters).toEqualData(characters)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/sheets/')
      expect(location.search()).toEqualData({keywords: keywords})
