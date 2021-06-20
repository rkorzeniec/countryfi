import { config, library, dom } from '@fortawesome/fontawesome-svg-core'

import {
  faEdit,
  faTrash,
  faPlus,
  faTasks,
  faPassport,
  faChartLine,
  faShareAlt,
  faHeart,
  faTerminal,
  faCheck,
  faBars,
  faBell,
  faCalendarCheck,
  faSpaceShuttle,
  faTimes,
  faCloud,
  faCloudDownloadAlt,
  faShareAltSquare
} from '@fortawesome/free-solid-svg-icons'

import {
  faUser,
  faClipboard
} from '@fortawesome/free-regular-svg-icons'

config.mutateApproach = 'sync'

library.add(
  faEdit,
  faTrash,
  faPlus,
  faTasks,
  faPassport,
  faChartLine,
  faShareAlt,
  faHeart,
  faTerminal,
  faCheck,
  faBars,
  faUser,
  faBell,
  faCalendarCheck,
  faSpaceShuttle,
  faTimes,
  faClipboard,
  faCloud,
  faCloudDownloadAlt,
  faShareAltSquare
)

dom.watch()
