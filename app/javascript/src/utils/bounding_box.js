export function getBoundingBox(data) {
    const bounds = {}

    // Loop through each "feature"
    for (let i = 0; i < data.features.length; i++) {
      const coordinates = data.features[i].geometry.coordinates;

      if(coordinates.length === 1){
        // It's only a single Polygon
        // For each individual coordinate in this feature's coordinates...
        for (let j = 0; j < coordinates[0].length; j++) {
          const longitude = coordinates[0][j][0];
          const latitude  = coordinates[0][j][1];

          // Update the bounds recursively by comparing the current xMin/xMax and yMin/yMax with the current coordinate
          bounds.xMin = bounds.xMin < longitude ? bounds.xMin : longitude;
          bounds.xMax = bounds.xMax > longitude ? bounds.xMax : longitude;
          bounds.yMin = bounds.yMin < latitude ? bounds.yMin : latitude;
          bounds.yMax = bounds.yMax > latitude ? bounds.yMax : latitude;
        }
      } else {
        // It's a MultiPolygon
        // Loop through each coordinate set
        for (let j = 0; j < coordinates.length; j++) {
          // For each individual coordinate in this coordinate set...
          for (let k = 0; k < coordinates[j][0].length; k++) {
            const longitude = coordinates[j][0][k][0];
            const latitude  = coordinates[j][0][k][1];

            // Update the bounds recursively by comparing the current xMin/xMax and yMin/yMax with the current coordinate
            bounds.xMin = bounds.xMin < longitude ? bounds.xMin : longitude;
            bounds.xMax = bounds.xMax > longitude ? bounds.xMax : longitude;
            bounds.yMin = bounds.yMin < latitude ? bounds.yMin : latitude;
            bounds.yMax = bounds.yMax > latitude ? bounds.yMax : latitude;
          }
        }
      }
    }

    const southWest = [bounds.xMin, bounds.yMax]
    const northEast = [bounds.xMax, bounds.yMin]

    return [southWest, northEast];
  }
