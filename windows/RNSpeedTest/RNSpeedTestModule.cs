using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RNSpeedTest
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNSpeedTestModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNSpeedTestModule"/>.
        /// </summary>
        internal RNSpeedTestModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNSpeedTest";
            }
        }
    }
}
