; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [170 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [510 x i32] [
	i32 u0x0027eb9e, ; 0: System.Net.NetworkInformation.dll => 126
	i32 u0x00345a11, ; 1: lib_System.Net.Requests.dll.so => 128
	i32 u0x009b21bb, ; 2: System.Net.NameResolution.dll => 125
	i32 u0x009ca7e2, ; 3: LiveChartsCore.SkiaSharpView.dll => 40
	i32 u0x00c8cc5d, ; 4: lib_Xamarin.AndroidX.Loader.dll.so => 81
	i32 u0x00e0bbf7, ; 5: lib_System.Xml.XmlSerializer.dll.so => 163
	i32 u0x0119bc86, ; 6: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 45
	i32 u0x0254c520, ; 7: Newtonsoft.Json.dll => 58
	i32 u0x025a8054, ; 8: System.Net.WebSockets.dll => 134
	i32 u0x02664405, ; 9: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i32 u0x028aa24d, ; 10: System.Threading.Thread => 157
	i32 u0x03358480, ; 11: lib_Microsoft.Maui.dll.so => 53
	i32 u0x0335cdbc, ; 12: ca/Microsoft.Maui.Controls.resources => 1
	i32 u0x044bb714, ; 13: Microsoft.Maui.Graphics.dll => 55
	i32 u0x056606a6, ; 14: lib_System.Collections.NonGeneric.dll.so => 103
	i32 u0x06c2cd46, ; 15: zh-HK/Microsoft.Maui.Controls.resources => 31
	i32 u0x06ffddbc, ; 16: System.Runtime.InteropServices => 143
	i32 u0x074aea82, ; 17: System.Threading.Channels.dll => 156
	i32 u0x0881c32f, ; 18: System.Net.WebHeaderCollection => 132
	i32 u0x0a0c2bd0, ; 19: lib_Xamarin.AndroidX.Activity.dll.so => 66
	i32 u0x0ad19b61, ; 20: lib_RestSharp.dll.so => 59
	i32 u0x0ade3a75, ; 21: Xamarin.AndroidX.SwipeRefreshLayout.dll => 88
	i32 u0x0aee6a3d, ; 22: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i32 u0x0aeedc53, ; 23: lib_Xamarin.Google.Android.Material.dll.so => 91
	i32 u0x0b721a36, ; 24: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i32 u0x0ba65f85, ; 25: vi/Microsoft.Maui.Controls.resources.dll => 30
	i32 u0x0ba8e231, ; 26: lib_System.Net.ServicePoint.dll.so => 130
	i32 u0x0be195c3, ; 27: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i32 u0x0c38ff48, ; 28: System.ComponentModel => 108
	i32 u0x0dc10265, ; 29: Microsoft.CSharp.dll => 100
	i32 u0x0dc2f416, ; 30: lib_Xamarin.AndroidX.CustomView.dll.so => 74
	i32 u0x0e762ada, ; 31: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i32 u0x0eb2f8c5, ; 32: System.Reflection.Emit.Lightweight => 141
	i32 u0x10bf9929, ; 33: cs/Microsoft.Maui.Controls.resources.dll => 2
	i32 u0x113d3381, ; 34: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i32 u0x13031348, ; 35: Xamarin.AndroidX.Activity.dll => 66
	i32 u0x136bf828, ; 36: lib_System.Runtime.dll.so => 148
	i32 u0x14095832, ; 37: ja/Microsoft.Maui.Controls.resources.dll => 15
	i32 u0x153e1455, ; 38: it/Microsoft.Maui.Controls.resources.dll => 14
	i32 u0x15502fa0, ; 39: cs/Microsoft.Maui.Controls.resources => 2
	i32 u0x15c177ae, ; 40: lib_Microsoft.Extensions.Configuration.dll.so => 42
	i32 u0x15e184df, ; 41: lib_System.Runtime.Loader.dll.so => 144
	i32 u0x16646418, ; 42: System.Net.ServicePoint.dll => 130
	i32 u0x16a510e1, ; 43: System.Threading.Thread.dll => 157
	i32 u0x16fe439a, ; 44: System.Memory.dll => 122
	i32 u0x17969339, ; 45: _Microsoft.Android.Resource.Designer => 34
	i32 u0x19f6996b, ; 46: sv/Microsoft.Maui.Controls.resources.dll => 26
	i32 u0x1a61054f, ; 47: System.Collections => 105
	i32 u0x1ae0ec2c, ; 48: Xamarin.AndroidX.Fragment.dll => 76
	i32 u0x1b317bfd, ; 49: System.Web.HttpUtility.dll => 159
	i32 u0x1b5932ea, ; 50: lib_Mono.Android.Runtime.dll.so => 168
	i32 u0x1b611806, ; 51: System.Runtime.Serialization.Primitives.dll => 147
	i32 u0x1bc6ffe7, ; 52: lib_Java.Interop.dll.so => 167
	i32 u0x1bff388e, ; 53: System.dll => 164
	i32 u0x1c78d08a, ; 54: lib_System.Private.Uri.dll.so => 137
	i32 u0x1dbae811, ; 55: System.ObjectModel => 136
	i32 u0x1dd2dc50, ; 56: id/Microsoft.Maui.Controls.resources.dll => 13
	i32 u0x1e092f31, ; 57: fi/Microsoft.Maui.Controls.resources.dll => 7
	i32 u0x1e9789de, ; 58: Microsoft.Extensions.Primitives.dll => 49
	i32 u0x1f4afcdc, ; 59: SkiaSharp.dll => 60
	i32 u0x1f6bf43d, ; 60: hi/Microsoft.Maui.Controls.resources => 10
	i32 u0x1fb393e1, ; 61: lib_SkiaSharp.Views.Maui.Controls.dll.so => 63
	i32 u0x20216150, ; 62: Microsoft.Extensions.Logging => 46
	i32 u0x234b6fb2, ; 63: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i32 u0x2397454a, ; 64: lib_System.Collections.Specialized.dll.so => 104
	i32 u0x239cf51b, ; 65: CommunityToolkit.Maui => 36
	i32 u0x2459aaf0, ; 66: lib_System.Net.Sockets.dll.so => 131
	i32 u0x24ad9868, ; 67: lib_SkiaSharp.Views.Android.dll.so => 62
	i32 u0x24f53b2c, ; 68: lib_Mopups.dll.so => 57
	i32 u0x2568904f, ; 69: Xamarin.AndroidX.CustomView => 74
	i32 u0x25c24e58, ; 70: lib_LiveChartsCore.SkiaSharpView.dll.so => 40
	i32 u0x262d781c, ; 71: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i32 u0x2645b6c3, ; 72: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i32 u0x271c8cd5, ; 73: lib_Microsoft.Maui.Maps.dll.so => 56
	i32 u0x27787397, ; 74: System.Text.Encodings.Web.dll => 153
	i32 u0x27b53050, ; 75: lib_System.Data.Common.dll.so => 110
	i32 u0x2814a96c, ; 76: System.Collections.Concurrent => 101
	i32 u0x28607aa1, ; 77: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i32 u0x28bdabca, ; 78: System.Net.Security => 129
	i32 u0x2904cf94, ; 79: ca/Microsoft.Maui.Controls.resources.dll => 1
	i32 u0x29293ff5, ; 80: System.Xml.Linq.dll => 160
	i32 u0x29423679, ; 81: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 73
	i32 u0x2a1e8ecb, ; 82: ko/Microsoft.Maui.Controls.resources.dll => 16
	i32 u0x2a4afd4a, ; 83: de/Microsoft.Maui.Controls.resources.dll => 4
	i32 u0x2b07b160, ; 84: lib_Xamarin.GooglePlayServices.Maps.dll.so => 94
	i32 u0x2b15ed29, ; 85: System.Runtime.Loader.dll => 144
	i32 u0x2d445acd, ; 86: System.Net.Requests => 128
	i32 u0x2e394f87, ; 87: System.IO.Compression => 118
	i32 u0x2e6ae22a, ; 88: SkiaSharp.HarfBuzz.dll => 61
	i32 u0x2f0980eb, ; 89: Microsoft.Extensions.Options => 48
	i32 u0x2ff6fb9f, ; 90: System.Data.Common => 110
	i32 u0x30a0e95c, ; 91: lib_System.Threading.Thread.dll.so => 157
	i32 u0x311247b5, ; 92: System.Private.Uri.dll => 137
	i32 u0x3142c245, ; 93: StreetLightApp.dll => 99
	i32 u0x317d5b75, ; 94: System.IO.Compression.Brotli => 117
	i32 u0x3312831d, ; 95: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 75
	i32 u0x33e88be1, ; 96: ar/Microsoft.Maui.Controls.resources => 0
	i32 u0x35e25008, ; 97: System.ComponentModel.Primitives.dll => 106
	i32 u0x362c87fc, ; 98: Microsoft.Maui.Maps => 56
	i32 u0x3635f196, ; 99: lib_Xamarin.GooglePlayServices.Basement.dll.so => 93
	i32 u0x373f6a31, ; 100: tr/Microsoft.Maui.Controls.resources.dll => 28
	i32 u0x37ea9cd7, ; 101: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 79
	i32 u0x38d89c1d, ; 102: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 77
	i32 u0x38f24a24, ; 103: Newtonsoft.Json => 58
	i32 u0x3a2aaa1d, ; 104: System.Xml.XDocument => 162
	i32 u0x3b2c715c, ; 105: System.Collections.dll => 105
	i32 u0x3b3271e4, ; 106: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i32 u0x3b4797e5, ; 107: es/Microsoft.Maui.Controls.resources => 6
	i32 u0x3c5e5b62, ; 108: Xamarin.AndroidX.SavedState.dll => 87
	i32 u0x3cbffa41, ; 109: System.Drawing => 115
	i32 u0x3d548d92, ; 110: Microsoft.Extensions.DependencyInjection.Abstractions => 45
	i32 u0x3d5a6611, ; 111: da/Microsoft.Maui.Controls.resources.dll => 3
	i32 u0x3da2de99, ; 112: LiveChartsCore.SkiaSharpView.Maui.dll => 41
	i32 u0x3dbaaf8f, ; 113: Xamarin.AndroidX.AppCompat => 67
	i32 u0x3dc84a49, ; 114: System.Drawing.Primitives.dll => 114
	i32 u0x3e444eb4, ; 115: System.Linq.Expressions.dll => 120
	i32 u0x3ebd41f6, ; 116: lib_System.Collections.dll.so => 105
	i32 u0x3eea4db8, ; 117: lib_Microsoft.Extensions.Primitives.dll.so => 49
	i32 u0x408b17f4, ; 118: System.ComponentModel.TypeConverter => 107
	i32 u0x409e66d8, ; 119: Xamarin.Kotlin.StdLib => 96
	i32 u0x41761b2c, ; 120: System => 164
	i32 u0x417c4c3b, ; 121: lib_AsyncAwaitBestPractices.dll.so => 35
	i32 u0x42be2972, ; 122: lib_System.Text.Encodings.Web.dll.so => 153
	i32 u0x4393e151, ; 123: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i32 u0x444e5c8e, ; 124: lib_System.ComponentModel.TypeConverter.dll.so => 107
	i32 u0x4474042c, ; 125: lib_System.Numerics.Vectors.dll.so => 135
	i32 u0x44845810, ; 126: lib_System.Net.Http.dll.so => 123
	i32 u0x463a8801, ; 127: Xamarin.AndroidX.Navigation.Runtime.dll => 84
	i32 u0x464305ed, ; 128: fi/Microsoft.Maui.Controls.resources => 7
	i32 u0x47b79c15, ; 129: pl/Microsoft.Maui.Controls.resources.dll => 20
	i32 u0x480a69ad, ; 130: System.Diagnostics.Process => 112
	i32 u0x4875091e, ; 131: lib_SkiaSharp.Views.Maui.Core.dll.so => 64
	i32 u0x499b8219, ; 132: nb/Microsoft.Maui.Controls.resources.dll => 18
	i32 u0x4a0189ae, ; 133: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i32 u0x4a4cd262, ; 134: Xamarin.AndroidX.Collection.Jvm.dll => 70
	i32 u0x4aa1e686, ; 135: lib_SkiaSharp.dll.so => 60
	i32 u0x4ac74f3b, ; 136: lib_LiveChartsCore.dll.so => 39
	i32 u0x4ae97402, ; 137: lib_Microsoft.Maui.Graphics.dll.so => 55
	i32 u0x4b275854, ; 138: Xamarin.KotlinX.Serialization.Core.Jvm => 98
	i32 u0x4b863c7a, ; 139: lib_System.Private.Xml.Linq.dll.so => 138
	i32 u0x4c7f86a2, ; 140: LiveChartsCore.SkiaSharpView => 40
	i32 u0x4d14ee2b, ; 141: Xamarin.AndroidX.DrawerLayout.dll => 75
	i32 u0x4eed2679, ; 142: System.Linq => 121
	i32 u0x50255dd9, ; 143: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i32 u0x50acdfd7, ; 144: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i32 u0x52114ed3, ; 145: Xamarin.AndroidX.SavedState => 87
	i32 u0x533678bd, ; 146: lib_System.Private.CoreLib.dll.so => 166
	i32 u0x53cefc50, ; 147: Xamarin.AndroidX.CoordinatorLayout => 71
	i32 u0x53f80ba6, ; 148: System.Runtime.Serialization.Formatters.dll => 146
	i32 u0x55ab7451, ; 149: Xamarin.AndroidX.Lifecycle.Common.Jvm => 77
	i32 u0x55b0fe2e, ; 150: lib_WatsonWebsocket.dll.so => 65
	i32 u0x55e55df2, ; 151: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 79
	i32 u0x568cd628, ; 152: System.Formats.Asn1.dll => 116
	i32 u0x56e7a7ad, ; 153: System.Net.Security.dll => 129
	i32 u0x5718a9ef, ; 154: System.Collections.Immutable.dll => 102
	i32 u0x57261233, ; 155: System.IO.Compression.dll => 118
	i32 u0x57924923, ; 156: Xamarin.AndroidX.AppCompat.AppCompatResources => 68
	i32 u0x57a5e912, ; 157: Microsoft.Extensions.Primitives => 49
	i32 u0x5833866d, ; 158: System.Collections.Immutable => 102
	i32 u0x583e844f, ; 159: System.IO.Compression.Brotli.dll => 117
	i32 u0x58fd6613, ; 160: hi/Microsoft.Maui.Controls.resources.dll => 10
	i32 u0x596b5b3a, ; 161: lib_System.Drawing.Primitives.dll.so => 114
	i32 u0x5a48cf6c, ; 162: el/Microsoft.Maui.Controls.resources.dll => 5
	i32 u0x5bf8ca0f, ; 163: System.Text.RegularExpressions.dll => 155
	i32 u0x5c7be408, ; 164: sk/Microsoft.Maui.Controls.resources.dll => 25
	i32 u0x5cabc9a4, ; 165: fr/Microsoft.Maui.Controls.resources => 8
	i32 u0x5e0b6fdc, ; 166: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 98
	i32 u0x5e33306d, ; 167: sv/Microsoft.Maui.Controls.resources => 26
	i32 u0x5e7321d2, ; 168: lib_System.ComponentModel.Primitives.dll.so => 106
	i32 u0x5ed5f779, ; 169: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i32 u0x6078995d, ; 170: System.Net.WebSockets.Client.dll => 133
	i32 u0x60b0136a, ; 171: Xamarin.AndroidX.Loader.dll => 81
	i32 u0x60c041a9, ; 172: SkiaSharp.Views.Maui.Controls => 63
	i32 u0x60d97228, ; 173: Xamarin.AndroidX.ViewPager2 => 90
	i32 u0x616edae3, ; 174: CommunityToolkit.Maui.Core.dll => 37
	i32 u0x6188ba7e, ; 175: Xamarin.AndroidX.CursorAdapter => 73
	i32 u0x61b9038d, ; 176: System.Net.Http.dll => 123
	i32 u0x61c036ca, ; 177: System.Text.RegularExpressions => 155
	i32 u0x62021776, ; 178: lib_System.IO.Compression.dll.so => 118
	i32 u0x620a8774, ; 179: lib_System.Xml.ReaderWriter.dll.so => 161
	i32 u0x62c6282e, ; 180: System.Runtime => 148
	i32 u0x62cec1a2, ; 181: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 97
	i32 u0x62d6ea10, ; 182: Xamarin.Google.Android.Material.dll => 91
	i32 u0x63635343, ; 183: Mopups.dll => 57
	i32 u0x63fca3d0, ; 184: System.Net.Primitives.dll => 127
	i32 u0x640c0103, ; 185: System.Net.WebSockets => 134
	i32 u0x641f3e5a, ; 186: System.Security.Cryptography => 150
	i32 u0x6715dc86, ; 187: Xamarin.AndroidX.CardView.dll => 69
	i32 u0x677cd287, ; 188: ro/Microsoft.Maui.Controls.resources.dll => 23
	i32 u0x67965db9, ; 189: lib_Microsoft.Maui.Controls.Maps.dll.so => 51
	i32 u0x68139a0d, ; 190: System.IO.Pipelines.dll => 119
	i32 u0x68f61ae4, ; 191: lib_System.Formats.Asn1.dll.so => 116
	i32 u0x690d4b7d, ; 192: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i32 u0x69239124, ; 193: System.Diagnostics.TraceSource.dll => 113
	i32 u0x693efa35, ; 194: lib_System.Net.WebHeaderCollection.dll.so => 132
	i32 u0x6947f945, ; 195: Xamarin.AndroidX.SwipeRefreshLayout => 88
	i32 u0x6988f147, ; 196: Microsoft.Extensions.Logging.dll => 46
	i32 u0x69f4f41d, ; 197: lib_Xamarin.AndroidX.AppCompat.dll.so => 67
	i32 u0x6a216153, ; 198: Mono.Android.Runtime.dll => 168
	i32 u0x6a96652d, ; 199: Xamarin.AndroidX.Fragment => 76
	i32 u0x6afaf338, ; 200: lib_System.Threading.dll.so => 158
	i32 u0x6b645ada, ; 201: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i32 u0x6bcd3296, ; 202: Xamarin.AndroidX.Loader => 81
	i32 u0x6be1e423, ; 203: nb/Microsoft.Maui.Controls.resources => 18
	i32 u0x6be29904, ; 204: lib_Xamarin.GooglePlayServices.Base.dll.so => 92
	i32 u0x6c111525, ; 205: Xamarin.Kotlin.StdLib.dll => 96
	i32 u0x6c13413e, ; 206: Xamarin.Google.Android.Material => 91
	i32 u0x6c652ce8, ; 207: Xamarin.AndroidX.Navigation.UI.dll => 85
	i32 u0x6c96614d, ; 208: hu/Microsoft.Maui.Controls.resources => 12
	i32 u0x6cbab720, ; 209: System.Text.Encoding.Extensions => 152
	i32 u0x6cc30c8c, ; 210: System.Runtime.Serialization.Formatters => 146
	i32 u0x6cff90ba, ; 211: Microsoft.Extensions.Logging.Abstractions.dll => 47
	i32 u0x6dcaebf7, ; 212: uk/Microsoft.Maui.Controls.resources.dll => 29
	i32 u0x6ec71a65, ; 213: System.Linq.Expressions => 120
	i32 u0x6f7a29e4, ; 214: System.Reflection.Primitives => 142
	i32 u0x7070c6c0, ; 215: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i32 u0x71c62d98, ; 216: Xamarin.GooglePlayServices.Basement => 93
	i32 u0x71dc7c8b, ; 217: System.Collections.NonGeneric.dll => 103
	i32 u0x72fcebde, ; 218: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 68
	i32 u0x731dd955, ; 219: lib_Mono.Android.dll.so => 169
	i32 u0x7328e1fd, ; 220: lib_SkiaSharp.HarfBuzz.dll.so => 61
	i32 u0x739bd4a8, ; 221: System.Private.Xml.Linq => 138
	i32 u0x73fbecbe, ; 222: lib_System.Memory.dll.so => 122
	i32 u0x74d743bf, ; 223: ja/Microsoft.Maui.Controls.resources => 15
	i32 u0x75533a5e, ; 224: Microsoft.Extensions.Configuration.dll => 42
	i32 u0x7554eac3, ; 225: AsyncAwaitBestPractices => 35
	i32 u0x781074ce, ; 226: hr/Microsoft.Maui.Controls.resources => 11
	i32 u0x78b622b1, ; 227: ar/Microsoft.Maui.Controls.resources.dll => 0
	i32 u0x7970be4f, ; 228: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i32 u0x79d00016, ; 229: it/Microsoft.Maui.Controls.resources => 14
	i32 u0x79eb68ee, ; 230: System.Private.Xml => 139
	i32 u0x7a80bd4e, ; 231: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 78
	i32 u0x7b350579, ; 232: lib__Microsoft.Android.Resource.Designer.dll.so => 34
	i32 u0x7b6f419e, ; 233: System.Diagnostics.TraceSource => 113
	i32 u0x7bf8cdab, ; 234: System.Runtime.dll => 148
	i32 u0x7c51ebd4, ; 235: lib_System.Net.HttpListener.dll.so => 124
	i32 u0x7c9bf920, ; 236: System.Numerics.Vectors => 135
	i32 u0x7ec9ffe9, ; 237: System.Console => 109
	i32 u0x7eed5835, ; 238: Xamarin.GooglePlayServices.Base.dll => 92
	i32 u0x7fb38cd2, ; 239: System.Collections.Specialized => 104
	i32 u0x7fc7a41e, ; 240: System.Xml.XmlSerializer.dll => 163
	i32 u0x7fdcdc37, ; 241: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i32 u0x8030853e, ; 242: ko/Microsoft.Maui.Controls.resources => 16
	i32 u0x8044e1bd, ; 243: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i32 u0x80bd55ad, ; 244: Microsoft.Maui => 53
	i32 u0x80f2f56e, ; 245: lib_System.Runtime.Serialization.Formatters.dll.so => 146
	i32 u0x810c11c2, ; 246: ro/Microsoft.Maui.Controls.resources => 23
	i32 u0x816751d8, ; 247: lib_System.Diagnostics.DiagnosticSource.dll.so => 111
	i32 u0x820d22b3, ; 248: Microsoft.Extensions.Options.dll => 48
	i32 u0x82a8237c, ; 249: Microsoft.Extensions.Logging.Abstractions => 47
	i32 u0x82b6c85e, ; 250: System.ObjectModel.dll => 136
	i32 u0x82bb5429, ; 251: lib_System.Linq.Expressions.dll.so => 120
	i32 u0x83323b38, ; 252: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 97
	i32 u0x8334206b, ; 253: System.Net.Http => 123
	i32 u0x835b1032, ; 254: lib_LiveChartsCore.SkiaSharpView.Maui.dll.so => 41
	i32 u0x857e4dd2, ; 255: lib_System.Net.WebSockets.dll.so => 134
	i32 u0x8628f1a4, ; 256: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i32 u0x86bba59b, ; 257: lib_Microsoft.Maui.Controls.dll.so => 50
	i32 u0x871c9c1b, ; 258: Microsoft.Extensions.Configuration.Abstractions => 43
	i32 u0x875633cc, ; 259: fr/Microsoft.Maui.Controls.resources.dll => 8
	i32 u0x87a1a22b, ; 260: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i32 u0x87e25095, ; 261: Xamarin.AndroidX.RecyclerView.dll => 86
	i32 u0x87e7fdbb, ; 262: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i32 u0x881f94da, ; 263: lib_netstandard.dll.so => 165
	i32 u0x8873eb17, ; 264: th/Microsoft.Maui.Controls.resources => 27
	i32 u0x88d8bfaa, ; 265: System.Net.Sockets => 131
	i32 u0x89461bcb, ; 266: Microsoft.Maui.Controls.Maps.dll => 51
	i32 u0x896b7878, ; 267: System.Private.CoreLib.dll => 166
	i32 u0x8c20c628, ; 268: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i32 u0x8c20f140, ; 269: lib_System.Console.dll.so => 109
	i32 u0x8c40e0db, ; 270: System.Net.Primitives => 127
	i32 u0x8ceadb42, ; 271: SkiaSharp.Views.Maui.Core => 64
	i32 u0x8d24e767, ; 272: System.Xml.ReaderWriter.dll => 161
	i32 u0x8d3fac99, ; 273: tr/Microsoft.Maui.Controls.resources => 28
	i32 u0x8d52b2e2, ; 274: Microsoft.Extensions.Configuration => 42
	i32 u0x8dcb0101, ; 275: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 83
	i32 u0x8e02310f, ; 276: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i32 u0x8e114655, ; 277: System.Security.Principal.Windows.dll => 151
	i32 u0x8f24faee, ; 278: System.Web.HttpUtility => 159
	i32 u0x8f8c64e2, ; 279: lib_System.Private.Xml.dll.so => 139
	i32 u0x905caa9d, ; 280: nl/Microsoft.Maui.Controls.resources => 19
	i32 u0x90e50509, ; 281: lib_System.Reflection.Primitives.dll.so => 142
	i32 u0x911615a7, ; 282: lib_Xamarin.AndroidX.Fragment.dll.so => 76
	i32 u0x912896e5, ; 283: System.Console.dll => 109
	i32 u0x928c75ca, ; 284: System.Net.Sockets.dll => 131
	i32 u0x93554fdc, ; 285: netstandard.dll => 165
	i32 u0x93918882, ; 286: Java.Interop.dll => 167
	i32 u0x93dba8a1, ; 287: Microsoft.Maui.Controls => 50
	i32 u0x94147f61, ; 288: System.Net.ServicePoint => 130
	i32 u0x9438d78e, ; 289: lib_System.Text.Json.dll.so => 154
	i32 u0x94a1db18, ; 290: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i32 u0x9593ae7f, ; 291: lib_Xamarin.AndroidX.SavedState.dll.so => 87
	i32 u0x963ac2da, ; 292: sk/Microsoft.Maui.Controls.resources => 25
	i32 u0x96bea474, ; 293: lib_Microsoft.Maui.Controls.Xaml.dll.so => 52
	i32 u0x974b89a2, ; 294: System.Reflection.Emit.Lightweight.dll => 141
	i32 u0x98602b60, ; 295: LiveChartsCore.SkiaSharpView.Maui => 41
	i32 u0x98ba5a04, ; 296: Microsoft.CSharp => 100
	i32 u0x98e90c02, ; 297: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 95
	i32 u0x9930ee42, ; 298: System.Text.Encodings.Web => 153
	i32 u0x9a1756ac, ; 299: System.Text.Encoding.Extensions.dll => 152
	i32 u0x9b24ab96, ; 300: lib_System.Runtime.Serialization.Primitives.dll.so => 147
	i32 u0x9b500441, ; 301: Xamarin.KotlinX.Coroutines.Core.Jvm => 97
	i32 u0x9bfe3a41, ; 302: System.Private.Xml.dll => 139
	i32 u0x9c375496, ; 303: Xamarin.AndroidX.CursorAdapter.dll => 73
	i32 u0x9c7b825b, ; 304: SkiaSharp.Views.Maui.Core.dll => 64
	i32 u0x9c96ac4c, ; 305: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 85
	i32 u0x9e78dac1, ; 306: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 80
	i32 u0x9ec4cf01, ; 307: System.Runtime.Loader => 144
	i32 u0x9ecf752a, ; 308: System.Xml.XDocument.dll => 162
	i32 u0x9ee22cc0, ; 309: System.Drawing.Primitives => 114
	i32 u0x9f7ea921, ; 310: lib_System.Runtime.InteropServices.dll.so => 143
	i32 u0x9f8c6f40, ; 311: System.Data.Common.dll => 110
	i32 u0xa0fb56af, ; 312: lib_System.Text.RegularExpressions.dll.so => 155
	i32 u0xa1fd7d9f, ; 313: System.Security.Claims => 149
	i32 u0xa25c90e5, ; 314: lib_Xamarin.AndroidX.Core.dll.so => 72
	i32 u0xa262a30f, ; 315: System.Runtime.Numerics.dll => 145
	i32 u0xa2ce8457, ; 316: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i32 u0xa2e0939b, ; 317: Xamarin.AndroidX.Activity => 66
	i32 u0xa30769e5, ; 318: System.Threading.Channels => 156
	i32 u0xa32eb6f0, ; 319: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 68
	i32 u0xa3c818c7, ; 320: lib_System.Net.WebSockets.Client.dll.so => 133
	i32 u0xa4672f3b, ; 321: Microsoft.Maui.Controls.Xaml => 52
	i32 u0xa493aa02, ; 322: lib_System.Collections.Concurrent.dll.so => 101
	i32 u0xa4caf7a7, ; 323: Microsoft.Maui.dll => 53
	i32 u0xa4e79dfd, ; 324: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 79
	i32 u0xa5a0a402, ; 325: Xamarin.AndroidX.ViewPager.dll => 89
	i32 u0xa5b67c07, ; 326: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 77
	i32 u0xa5c5753c, ; 327: lib_System.Collections.Immutable.dll.so => 102
	i32 u0xa668c988, ; 328: lib_System.Net.NameResolution.dll.so => 125
	i32 u0xa6a180a8, ; 329: SkiaSharp.Views.Android.dll => 62
	i32 u0xa7008e0b, ; 330: Microsoft.Maui.Graphics => 55
	i32 u0xa7042ae3, ; 331: uk/Microsoft.Maui.Controls.resources => 29
	i32 u0xa741ef0b, ; 332: es/Microsoft.Maui.Controls.resources.dll => 6
	i32 u0xa744f665, ; 333: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 84
	i32 u0xa78103bc, ; 334: Xamarin.AndroidX.CoordinatorLayout.dll => 71
	i32 u0xa81b119f, ; 335: lib_System.Security.Cryptography.dll.so => 150
	i32 u0xa8c61dcb, ; 336: nl/Microsoft.Maui.Controls.resources.dll => 19
	i32 u0xa9b829f7, ; 337: Xamarin.GooglePlayServices.Base => 92
	i32 u0xaa107fc4, ; 338: Xamarin.AndroidX.ViewPager => 89
	i32 u0xaa4e51ff, ; 339: el/Microsoft.Maui.Controls.resources => 5
	i32 u0xaa8a4878, ; 340: Microsoft.Maui.Essentials => 54
	i32 u0xaaf9aad7, ; 341: CommunityToolkit.Maui.Core => 37
	i32 u0xabbc23e8, ; 342: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 98
	i32 u0xabdea79a, ; 343: ru/Microsoft.Maui.Controls.resources => 24
	i32 u0xace7ba82, ; 344: lib_System.Security.Principal.Windows.dll.so => 151
	i32 u0xad6f1e8a, ; 345: System.Private.CoreLib => 166
	i32 u0xad9910a4, ; 346: SkiaSharp.Views.Android => 62
	i32 u0xaddb6d38, ; 347: Xamarin.AndroidX.ViewPager2.dll => 90
	i32 u0xae037813, ; 348: System.Numerics.Vectors.dll => 135
	i32 u0xaeb2d8a5, ; 349: lib_Microsoft.Extensions.Options.dll.so => 48
	i32 u0xb0682092, ; 350: System.ComponentModel.dll => 108
	i32 u0xb0ed41f3, ; 351: System.Security.Principal.Windows => 151
	i32 u0xb18af942, ; 352: Xamarin.AndroidX.DrawerLayout => 75
	i32 u0xb1a434a2, ; 353: lib_System.Xml.Linq.dll.so => 160
	i32 u0xb223fa8c, ; 354: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i32 u0xb3d4efc5, ; 355: Xamarin.GooglePlayServices.Maps => 94
	i32 u0xb514b305, ; 356: _Microsoft.Android.Resource.Designer.dll => 34
	i32 u0xb63fa9f0, ; 357: Xamarin.AndroidX.Navigation.Common => 82
	i32 u0xb646e70c, ; 358: Xamarin.GooglePlayServices.Tasks => 95
	i32 u0xb65adef9, ; 359: Mono.Android.Runtime => 168
	i32 u0xb65daa69, ; 360: lib_StreetLightApp.dll.so => 99
	i32 u0xb660be12, ; 361: System.ComponentModel.Primitives => 106
	i32 u0xb6a153b2, ; 362: lib_Xamarin.AndroidX.ViewPager2.dll.so => 90
	i32 u0xb76be845, ; 363: hu/Microsoft.Maui.Controls.resources.dll => 12
	i32 u0xb7af1a23, ; 364: LiveChartsCore => 39
	i32 u0xb8c22b7f, ; 365: System.Security.Claims.dll => 149
	i32 u0xb8fd311b, ; 366: System.Formats.Asn1 => 116
	i32 u0xb95819ac, ; 367: lib_HarfBuzzSharp.dll.so => 38
	i32 u0xbaa520e7, ; 368: lib_System.ObjectModel.dll.so => 136
	i32 u0xbc4c6465, ; 369: System.Reflection.Primitives.dll => 142
	i32 u0xbc98c93d, ; 370: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 70
	i32 u0xbd113355, ; 371: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 82
	i32 u0xbd78b0c8, ; 372: Xamarin.AndroidX.Navigation.Fragment.dll => 83
	i32 u0xbff2e236, ; 373: System.Threading => 158
	i32 u0xc00e375b, ; 374: lib_Newtonsoft.Json.dll.so => 58
	i32 u0xc08d007e, ; 375: Xamarin.GooglePlayServices.Basement.dll => 93
	i32 u0xc1abc74d, ; 376: RestSharp.dll => 59
	i32 u0xc235e84d, ; 377: Xamarin.AndroidX.CardView => 69
	i32 u0xc3428433, ; 378: lib_System.Reflection.Emit.ILGeneration.dll.so => 140
	i32 u0xc591efe9, ; 379: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 43
	i32 u0xc5b097e4, ; 380: System.Net.Requests.dll => 128
	i32 u0xc5b776df, ; 381: Xamarin.AndroidX.CustomView.dll => 74
	i32 u0xc71a4669, ; 382: SkiaSharp => 60
	i32 u0xc774da4f, ; 383: Xamarin.AndroidX.Navigation.Runtime => 84
	i32 u0xc821fc10, ; 384: lib_System.ComponentModel.dll.so => 108
	i32 u0xc82afec1, ; 385: System.Text.Json => 154
	i32 u0xc86c06e3, ; 386: Xamarin.AndroidX.Core => 72
	i32 u0xc8a662e9, ; 387: Java.Interop => 167
	i32 u0xc8d10307, ; 388: lib_System.Diagnostics.TraceSource.dll.so => 113
	i32 u0xc92a6809, ; 389: Xamarin.AndroidX.RecyclerView => 86
	i32 u0xc9bc2845, ; 390: LiveChartsCore.dll => 39
	i32 u0xcb5af55c, ; 391: lib_System.Reflection.Emit.Lightweight.dll.so => 141
	i32 u0xcc5af6ee, ; 392: Microsoft.Extensions.DependencyInjection.dll => 44
	i32 u0xcc7d82b4, ; 393: netstandard => 165
	i32 u0xce3fa116, ; 394: lib_System.Diagnostics.Process.dll.so => 112
	i32 u0xce70fda2, ; 395: hr/Microsoft.Maui.Controls.resources.dll => 11
	i32 u0xcef19b37, ; 396: System.ComponentModel.TypeConverter.dll => 107
	i32 u0xcf042b44, ; 397: SkiaSharp.Views.Maui.Controls.dll => 63
	i32 u0xcf3163e6, ; 398: Mono.Android => 169
	i32 u0xcf663a21, ; 399: ru/Microsoft.Maui.Controls.resources.dll => 24
	i32 u0xcfa20c36, ; 400: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 88
	i32 u0xcfbaacae, ; 401: System.Text.Json.dll => 154
	i32 u0xd0a98ee2, ; 402: Microsoft.Maui.Controls.Maps => 51
	i32 u0xd128d608, ; 403: System.Xml.Linq => 160
	i32 u0xd2ff69f1, ; 404: System.Net.HttpListener => 124
	i32 u0xd328ac54, ; 405: vi/Microsoft.Maui.Controls.resources => 30
	i32 u0xd4045e1b, ; 406: lib_System.dll.so => 164
	i32 u0xd457e5c9, ; 407: lib_Microsoft.CSharp.dll.so => 100
	i32 u0xd45fd3d5, ; 408: WatsonWebsocket.dll => 65
	i32 u0xd622b752, ; 409: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i32 u0xd664cdf2, ; 410: de/Microsoft.Maui.Controls.resources => 4
	i32 u0xd67a52b3, ; 411: System.Net.WebSockets.Client => 133
	i32 u0xd715a361, ; 412: System.Linq.dll => 121
	i32 u0xd77927f1, ; 413: StreetLightApp => 99
	i32 u0xd7f95f5a, ; 414: da/Microsoft.Maui.Controls.resources => 3
	i32 u0xd889aee8, ; 415: lib_System.Threading.Channels.dll.so => 156
	i32 u0xd8bba49d, ; 416: lib_Xamarin.AndroidX.RecyclerView.dll.so => 86
	i32 u0xd90e5f5a, ; 417: Xamarin.AndroidX.Lifecycle.LiveData.Core => 78
	i32 u0xd930cda0, ; 418: Xamarin.AndroidX.Navigation.Fragment => 83
	i32 u0xd96cf6f7, ; 419: pt-BR/Microsoft.Maui.Controls.resources => 21
	i32 u0xd9f65f5e, ; 420: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i32 u0xd9fdda56, ; 421: Microsoft.Extensions.Configuration.Abstractions.dll => 43
	i32 u0xda2f27df, ; 422: System.Net.NetworkInformation => 126
	i32 u0xda4773dd, ; 423: he/Microsoft.Maui.Controls.resources => 9
	i32 u0xdae8aa5e, ; 424: Mono.Android.dll => 169
	i32 u0xdbb50d93, ; 425: ms/Microsoft.Maui.Controls.resources => 17
	i32 u0xdc5370c5, ; 426: lib_System.Web.HttpUtility.dll.so => 159
	i32 u0xdc68940c, ; 427: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i32 u0xde068c70, ; 428: Xamarin.AndroidX.Navigation.Common.dll => 82
	i32 u0xde7354ab, ; 429: System.Net.NameResolution => 125
	i32 u0xdf6f3870, ; 430: System.Diagnostics.DiagnosticSource => 111
	i32 u0xe0dec2ee, ; 431: lib_CommunityToolkit.Maui.dll.so => 36
	i32 u0xe13414bb, ; 432: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i32 u0xe1a41194, ; 433: lib_System.Xml.XDocument.dll.so => 162
	i32 u0xe1f0a5d8, ; 434: lib_Xamarin.AndroidX.ViewPager.dll.so => 89
	i32 u0xe2098b0b, ; 435: System.Collections.NonGeneric => 103
	i32 u0xe21214b8, ; 436: HarfBuzzSharp => 38
	i32 u0xe2197fa1, ; 437: AsyncAwaitBestPractices.dll => 35
	i32 u0xe250cda6, ; 438: lib_Microsoft.Extensions.Logging.dll.so => 46
	i32 u0xe2513246, ; 439: lib_System.Runtime.Numerics.dll.so => 145
	i32 u0xe2a3f2e8, ; 440: System.Collections.Specialized.dll => 104
	i32 u0xe34ee011, ; 441: lib_System.IO.Pipelines.dll.so => 119
	i32 u0xe37a36df, ; 442: RestSharp => 59
	i32 u0xe3886bf7, ; 443: CommunityToolkit.Maui.dll => 36
	i32 u0xe3c7860c, ; 444: lib_System.Security.Claims.dll.so => 149
	i32 u0xe3df9d2b, ; 445: System.Security.Cryptography.dll => 150
	i32 u0xe4fab729, ; 446: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 45
	i32 u0xe56ef253, ; 447: System.Runtime.InteropServices.dll => 143
	i32 u0xe625b819, ; 448: lib_Xamarin.AndroidX.CardView.dll.so => 69
	i32 u0xe6b14171, ; 449: System.Net.HttpListener.dll => 124
	i32 u0xe797fcc1, ; 450: System.Net.WebHeaderCollection.dll => 132
	i32 u0xe7dc15ff, ; 451: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i32 u0xe839deed, ; 452: System.Collections.Concurrent.dll => 101
	i32 u0xe843daa0, ; 453: Xamarin.AndroidX.Core.dll => 72
	i32 u0xe90fdb70, ; 454: Xamarin.AndroidX.Collection.Jvm => 70
	i32 u0xe99f7d24, ; 455: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i32 u0xea213423, ; 456: System.Xml.ReaderWriter => 161
	i32 u0xea4fb52e, ; 457: Xamarin.AndroidX.Navigation.UI => 85
	i32 u0xeab81858, ; 458: lib_Microsoft.Maui.Essentials.dll.so => 54
	i32 u0xeaf598f6, ; 459: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 47
	i32 u0xebb0254b, ; 460: lib_System.Net.NetworkInformation.dll.so => 126
	i32 u0xebc66336, ; 461: Xamarin.AndroidX.AppCompat.dll => 67
	i32 u0xeca1adaf, ; 462: Xamarin.GooglePlayServices.Tasks.dll => 95
	i32 u0xed1090ae, ; 463: lib_System.Net.Primitives.dll.so => 127
	i32 u0xed409aea, ; 464: th/Microsoft.Maui.Controls.resources.dll => 27
	i32 u0xed96d41f, ; 465: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 71
	i32 u0xedadd6e2, ; 466: he/Microsoft.Maui.Controls.resources.dll => 9
	i32 u0xedf6669b, ; 467: lib_System.Drawing.dll.so => 115
	i32 u0xee9f991d, ; 468: System.Diagnostics.Process.dll => 112
	i32 u0xeea6c4b6, ; 469: HarfBuzzSharp.dll => 38
	i32 u0xefd01a89, ; 470: System.IO.Pipelines => 119
	i32 u0xeff49a63, ; 471: System.Memory => 122
	i32 u0xeff49c4a, ; 472: lib_System.Text.Encoding.Extensions.dll.so => 152
	i32 u0xf04057de, ; 473: Mopups => 57
	i32 u0xf121f953, ; 474: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 78
	i32 u0xf1304331, ; 475: Microsoft.Maui.Controls.Xaml.dll => 52
	i32 u0xf1676aaa, ; 476: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i32 u0xf1ad867b, ; 477: System.Reflection.Emit.ILGeneration => 140
	i32 u0xf2667abc, ; 478: SkiaSharp.HarfBuzz => 61
	i32 u0xf27f60d1, ; 479: System.Private.Xml.Linq.dll => 138
	i32 u0xf29c5384, ; 480: id/Microsoft.Maui.Controls.resources => 13
	i32 u0xf2ce3c98, ; 481: System.Threading.dll => 158
	i32 u0xf2dd3fc4, ; 482: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i32 u0xf323e0a6, ; 483: lib_Xamarin.Kotlin.StdLib.dll.so => 96
	i32 u0xf40add04, ; 484: Microsoft.Maui.Essentials.dll => 54
	i32 u0xf45985cf, ; 485: System.Drawing.dll => 115
	i32 u0xf462c30d, ; 486: System.Private.Uri => 137
	i32 u0xf48143e5, ; 487: pt/Microsoft.Maui.Controls.resources.dll => 22
	i32 u0xf5185c24, ; 488: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i32 u0xf53cb11d, ; 489: lib_System.Net.Security.dll.so => 129
	i32 u0xf5861a4f, ; 490: pl/Microsoft.Maui.Controls.resources => 20
	i32 u0xf5e94e90, ; 491: ms/Microsoft.Maui.Controls.resources.dll => 17
	i32 u0xf5f4f1f0, ; 492: Microsoft.Extensions.DependencyInjection => 44
	i32 u0xf5fdf056, ; 493: lib_Microsoft.Extensions.DependencyInjection.dll.so => 44
	i32 u0xf73be021, ; 494: System.Reflection.Emit.ILGeneration.dll => 140
	i32 u0xf798e6c6, ; 495: WatsonWebsocket => 65
	i32 u0xf7e95c85, ; 496: System.Xml.XmlSerializer => 163
	i32 u0xf86129d4, ; 497: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i32 u0xf93ba7d4, ; 498: System.Runtime.Serialization.Primitives => 147
	i32 u0xf94a8f86, ; 499: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 80
	i32 u0xf9cd7515, ; 500: Microsoft.Maui.Maps.dll => 56
	i32 u0xfa50891f, ; 501: lib_System.Linq.dll.so => 121
	i32 u0xfb0af295, ; 502: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i32 u0xfb1dad5d, ; 503: System.Diagnostics.DiagnosticSource.dll => 111
	i32 u0xfbc4b67c, ; 504: lib_System.IO.Compression.Brotli.dll.so => 117
	i32 u0xfc5f7d36, ; 505: pt/Microsoft.Maui.Controls.resources => 22
	i32 u0xfea12dee, ; 506: Microsoft.Maui.Controls.dll => 50
	i32 u0xfecef6ea, ; 507: System.Runtime.Numerics => 145
	i32 u0xfeff2639, ; 508: Xamarin.GooglePlayServices.Maps.dll => 94
	i32 u0xffd4917f ; 509: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 80
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [510 x i32] [
	i32 126, i32 128, i32 125, i32 40, i32 81, i32 163, i32 45, i32 58,
	i32 134, i32 29, i32 157, i32 53, i32 1, i32 55, i32 103, i32 31,
	i32 143, i32 156, i32 132, i32 66, i32 59, i32 88, i32 30, i32 91,
	i32 20, i32 30, i32 130, i32 31, i32 108, i32 100, i32 74, i32 18,
	i32 141, i32 2, i32 25, i32 66, i32 148, i32 15, i32 14, i32 2,
	i32 42, i32 144, i32 130, i32 157, i32 122, i32 34, i32 26, i32 105,
	i32 76, i32 159, i32 168, i32 147, i32 167, i32 164, i32 137, i32 136,
	i32 13, i32 7, i32 49, i32 60, i32 10, i32 63, i32 46, i32 21,
	i32 104, i32 36, i32 131, i32 62, i32 57, i32 74, i32 40, i32 4,
	i32 37, i32 56, i32 153, i32 110, i32 101, i32 21, i32 129, i32 1,
	i32 160, i32 73, i32 16, i32 4, i32 94, i32 144, i32 128, i32 118,
	i32 61, i32 48, i32 110, i32 157, i32 137, i32 99, i32 117, i32 75,
	i32 0, i32 106, i32 56, i32 93, i32 28, i32 79, i32 77, i32 58,
	i32 162, i32 105, i32 32, i32 6, i32 87, i32 115, i32 45, i32 3,
	i32 41, i32 67, i32 114, i32 120, i32 105, i32 49, i32 107, i32 96,
	i32 164, i32 35, i32 153, i32 27, i32 107, i32 135, i32 123, i32 84,
	i32 7, i32 20, i32 112, i32 64, i32 18, i32 10, i32 70, i32 60,
	i32 39, i32 55, i32 98, i32 138, i32 40, i32 75, i32 121, i32 11,
	i32 1, i32 87, i32 166, i32 71, i32 146, i32 77, i32 65, i32 79,
	i32 116, i32 129, i32 102, i32 118, i32 68, i32 49, i32 102, i32 117,
	i32 10, i32 114, i32 5, i32 155, i32 25, i32 8, i32 98, i32 26,
	i32 106, i32 33, i32 133, i32 81, i32 63, i32 90, i32 37, i32 73,
	i32 123, i32 155, i32 118, i32 161, i32 148, i32 97, i32 91, i32 57,
	i32 127, i32 134, i32 150, i32 69, i32 23, i32 51, i32 119, i32 116,
	i32 33, i32 113, i32 132, i32 88, i32 46, i32 67, i32 168, i32 76,
	i32 158, i32 8, i32 81, i32 18, i32 92, i32 96, i32 91, i32 85,
	i32 12, i32 152, i32 146, i32 47, i32 29, i32 120, i32 142, i32 32,
	i32 93, i32 103, i32 68, i32 169, i32 61, i32 138, i32 122, i32 15,
	i32 42, i32 35, i32 11, i32 0, i32 9, i32 14, i32 139, i32 78,
	i32 34, i32 113, i32 148, i32 124, i32 135, i32 109, i32 92, i32 104,
	i32 163, i32 16, i32 16, i32 17, i32 53, i32 146, i32 23, i32 111,
	i32 48, i32 47, i32 136, i32 120, i32 97, i32 123, i32 41, i32 134,
	i32 24, i32 50, i32 43, i32 8, i32 14, i32 86, i32 19, i32 165,
	i32 27, i32 131, i32 51, i32 166, i32 7, i32 109, i32 127, i32 64,
	i32 161, i32 28, i32 42, i32 83, i32 0, i32 151, i32 159, i32 139,
	i32 19, i32 142, i32 76, i32 109, i32 131, i32 165, i32 167, i32 50,
	i32 130, i32 154, i32 13, i32 87, i32 25, i32 52, i32 141, i32 41,
	i32 100, i32 95, i32 153, i32 152, i32 147, i32 97, i32 139, i32 73,
	i32 64, i32 85, i32 80, i32 144, i32 162, i32 114, i32 143, i32 110,
	i32 155, i32 149, i32 72, i32 145, i32 6, i32 66, i32 156, i32 68,
	i32 133, i32 52, i32 101, i32 53, i32 79, i32 89, i32 77, i32 102,
	i32 125, i32 62, i32 55, i32 29, i32 6, i32 84, i32 71, i32 150,
	i32 19, i32 92, i32 89, i32 5, i32 54, i32 37, i32 98, i32 24,
	i32 151, i32 166, i32 62, i32 90, i32 135, i32 48, i32 108, i32 151,
	i32 75, i32 160, i32 2, i32 94, i32 34, i32 82, i32 95, i32 168,
	i32 99, i32 106, i32 90, i32 12, i32 39, i32 149, i32 116, i32 38,
	i32 136, i32 142, i32 70, i32 82, i32 83, i32 158, i32 58, i32 93,
	i32 59, i32 69, i32 140, i32 43, i32 128, i32 74, i32 60, i32 84,
	i32 108, i32 154, i32 72, i32 167, i32 113, i32 86, i32 39, i32 141,
	i32 44, i32 165, i32 112, i32 11, i32 107, i32 63, i32 169, i32 24,
	i32 88, i32 154, i32 51, i32 160, i32 124, i32 30, i32 164, i32 100,
	i32 65, i32 23, i32 4, i32 133, i32 121, i32 99, i32 3, i32 156,
	i32 86, i32 78, i32 83, i32 21, i32 5, i32 43, i32 126, i32 9,
	i32 169, i32 17, i32 159, i32 33, i32 82, i32 125, i32 111, i32 36,
	i32 12, i32 162, i32 89, i32 103, i32 38, i32 35, i32 46, i32 145,
	i32 104, i32 119, i32 59, i32 36, i32 149, i32 150, i32 45, i32 143,
	i32 69, i32 124, i32 132, i32 32, i32 101, i32 72, i32 70, i32 28,
	i32 161, i32 85, i32 54, i32 47, i32 126, i32 67, i32 95, i32 127,
	i32 27, i32 71, i32 9, i32 115, i32 112, i32 38, i32 119, i32 122,
	i32 152, i32 57, i32 78, i32 52, i32 3, i32 140, i32 61, i32 138,
	i32 13, i32 158, i32 15, i32 96, i32 54, i32 115, i32 137, i32 22,
	i32 22, i32 129, i32 20, i32 17, i32 44, i32 44, i32 140, i32 65,
	i32 163, i32 26, i32 147, i32 80, i32 56, i32 121, i32 31, i32 111,
	i32 117, i32 22, i32 50, i32 145, i32 94, i32 80
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ a618557d1fa38074e0256317fb17c1baee245a79"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}
