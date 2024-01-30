import QtQuick
import QtQuick.Layouts

Window {
  id: win
  width: 1920
  height: 1080
  visible: true
  // Random placements around Posters (another draggable asset type)
  property real placementX: 960
  property real placementY: 540

  // Handles locations and checks if the asset is on a Poster
  Rectangle {
    id: location
    objectName: "location"
    x: placementX
    y: placementY
    width: 1
    height: 1

    onXChanged: {
      if (location.x<0)
      {
        location.x = 0
      }
      if (x > win.width)
      {
        x = win.width
      }
    }

    onYChanged: {
      if (location.y<0)
      {
        location.y = 0
      }
      if (location.y > win.height)
      {
        location.y = win.height
      }
    }
  }

  // Custom class with assets cropping, masking, and touch filtering
  Rectangle {
    id: croppedImage
    objectName: "croppedImage"
    anchors.horizontalCenter: location.horizontalCenter
    anchors.verticalCenter: location.verticalCenter
    rotation: 0
    scale: 1
    transformOrigin: Item.Center
    width: 200
    height: 200

    // The actual image with shader effects
    Rectangle {
      x: 0
      y: 0
      width: 200
      height: 200
      color: "red"
      visible: true
    }

    // Drag Handler
    DragHandler {
      id:drag_handler
      target: null
      property point basePoint

      onActiveChanged: {
        if(active)
        {
          console.log("active changed")
          basePoint.x = location.x
          basePoint.y = location.y
        }
      }
      onActiveTranslationChanged: {
        console.log("activeTranslation: " + activeTranslation.x + " " + activeTranslation.y)
        location.x = basePoint.x + win.width * (activeTranslation.x / win.width)
        location.y = basePoint.y + win.height * (activeTranslation.y / win.height)
      }
    }
  }
}
