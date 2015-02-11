# Component API

## ui/gallery
Wrapper for [Swiper](http://www.idangero.us/sliders/swiper/)

### Options

Name | Type | Default | Description
-----|------|---------|------------
swiperConfig | hash| {} | config options for the Swiper; see "Options" section of [Swiper API](http://www.idangero.us/sliders/swiper/api.php)

### Events Received

#### uiGalleryContentReady
Let's the component know it can initialize the Swiper.

Data: None

#### uiGalleryWantsNextItem
Tell the Gallery/Swiper to transition to the next item.
Does nothing if `loop` config param is false (the default) and last item is active.

Data: None

#### uiGalleryWantsPrevItem
Tell the Gallery/Swiper to transition to the previous item.
Does nothing if `loop` config param is false (the default) and first item is active.

Data: None

#### uiGalleryWantsToGoToIndex
Tell the Gallery/Swiper to transition to a specific item index.

Data:

Name | Type | Required? | Description
-----|------|-----------|------------
index | int | yes | the index to go to
speed | int | no  | speed of animation in milliseconds; if unspecified the default speed for the swiper will be used; set to zero for no animation

### Events Sent

#### uiSwiperInitialized
Sent after the Swiper has been initialized.

Data:

Name | Type | Description
-----|------|------------
swiper | object | A Swiper instance. Refer to [Swiper API](http://www.idangero.us/sliders/swiper/api.php) for attributes and methods.

Note: Ideally use of the swiper instance should be limited and read-only. Calling methods of the swiper that change state breaks the encapsulation that the gallery component is designed to provide. For example: instead of calling `swiper.swiperNext()` trigger the event `uiGalleryWantsNextItem`. The main reason that this event is triggered with a reference to the swiper instance is to allow access to `swiper.support` (a hash of boolean flags that indicate browser features such as `touch`).

#### uiGallerySlideChanged
Sent whenever the active slide/item has changed. This happens in response to swiping and in response to events (uiGalleryWantsNextItem, etc).

Data:

Name | Type | Description
-----|------|------------
activeIndex | int | index of the currently active item
previousIndex | int | index of the previously active item
total | int | number of items/slides

#### uiGallerySlideClicked
Sent whenever a slide/item has been clicked.

Data:

Name | Type | Description
-----|------|------------
index | int | index of the clicked item

# TODO: document more components

## ui/content

## ui/counter

## ui/navigation_buttons

## ui/image_loader

## ui/gallery_syncer

## ui/keyboard_navigation
