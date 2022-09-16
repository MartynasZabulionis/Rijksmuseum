# rijksmuseum
An app developed with <b>Flutter</b></br>
- The app contains two screens: art objects list page and art objects details page.
- The page of list of art objects includes pagination (every page has 10 art objects) and infinite scroll.

## Technical information
- The concerns/responsibilities are split into different packages with the main lib package containing only UI stuff.
- Uses <b>melos</b> to manage the packages.
- Uses <b>bloc</b>s for UI state management.
- Uses <b>Dio</b> as a HTTP client.
- Uses <b>GetIt</b> as a service locator for accessing blocs in UI part, and <b>constructor dependency injection</b> for the rest usages.
- Contains unit and widget tests.
</br>
<p float="left">
<img src="https://user-images.githubusercontent.com/39856703/130061765-c640eeae-f643-45ea-93d3-4bb3f3154ce3.jpg" height="400">
<img src="https://user-images.githubusercontent.com/39856703/130061777-403cb570-b9aa-4b6c-8f6b-ff1d9a3ec3b0.jpg" height="400">
<img src="https://user-images.githubusercontent.com/39856703/130061788-abd0ad96-a4ab-402f-80a6-b3c27553a7ef.jpg" height="400">
<img src="https://user-images.githubusercontent.com/39856703/130061802-77d4edb2-357d-4ef8-bbe6-2839b229c731.jpg" height="400">
</p>
