; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [161 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [483 x i32] [
	i32 u0x0027eb9e, ; 0: System.Net.NetworkInformation.dll => 117
	i32 u0x00345a11, ; 1: lib_System.Net.Requests.dll.so => 119
	i32 u0x009b21bb, ; 2: System.Net.NameResolution.dll => 116
	i32 u0x00c8cc5d, ; 3: lib_Xamarin.AndroidX.Loader.dll.so => 72
	i32 u0x00e0bbf7, ; 4: lib_System.Xml.XmlSerializer.dll.so => 154
	i32 u0x0119bc86, ; 5: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 41
	i32 u0x0254c520, ; 6: Newtonsoft.Json.dll => 54
	i32 u0x025a8054, ; 7: System.Net.WebSockets.dll => 125
	i32 u0x02664405, ; 8: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i32 u0x028aa24d, ; 9: System.Threading.Thread => 148
	i32 u0x03358480, ; 10: lib_Microsoft.Maui.dll.so => 49
	i32 u0x0335cdbc, ; 11: ca/Microsoft.Maui.Controls.resources => 1
	i32 u0x044bb714, ; 12: Microsoft.Maui.Graphics.dll => 51
	i32 u0x056606a6, ; 13: lib_System.Collections.NonGeneric.dll.so => 94
	i32 u0x06c2cd46, ; 14: zh-HK/Microsoft.Maui.Controls.resources => 31
	i32 u0x06ffddbc, ; 15: System.Runtime.InteropServices => 134
	i32 u0x074aea82, ; 16: System.Threading.Channels.dll => 147
	i32 u0x0881c32f, ; 17: System.Net.WebHeaderCollection => 123
	i32 u0x0a0c2bd0, ; 18: lib_Xamarin.AndroidX.Activity.dll.so => 57
	i32 u0x0ad19b61, ; 19: lib_RestSharp.dll.so => 55
	i32 u0x0ade3a75, ; 20: Xamarin.AndroidX.SwipeRefreshLayout.dll => 79
	i32 u0x0aee6a3d, ; 21: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i32 u0x0aeedc53, ; 22: lib_Xamarin.Google.Android.Material.dll.so => 82
	i32 u0x0b721a36, ; 23: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i32 u0x0ba65f85, ; 24: vi/Microsoft.Maui.Controls.resources.dll => 30
	i32 u0x0ba8e231, ; 25: lib_System.Net.ServicePoint.dll.so => 121
	i32 u0x0be195c3, ; 26: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i32 u0x0c38ff48, ; 27: System.ComponentModel => 99
	i32 u0x0dc10265, ; 28: Microsoft.CSharp.dll => 91
	i32 u0x0dc2f416, ; 29: lib_Xamarin.AndroidX.CustomView.dll.so => 65
	i32 u0x0e762ada, ; 30: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i32 u0x0eb2f8c5, ; 31: System.Reflection.Emit.Lightweight => 132
	i32 u0x10bf9929, ; 32: cs/Microsoft.Maui.Controls.resources.dll => 2
	i32 u0x113d3381, ; 33: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i32 u0x13031348, ; 34: Xamarin.AndroidX.Activity.dll => 57
	i32 u0x136bf828, ; 35: lib_System.Runtime.dll.so => 139
	i32 u0x14095832, ; 36: ja/Microsoft.Maui.Controls.resources.dll => 15
	i32 u0x153e1455, ; 37: it/Microsoft.Maui.Controls.resources.dll => 14
	i32 u0x15502fa0, ; 38: cs/Microsoft.Maui.Controls.resources => 2
	i32 u0x15c177ae, ; 39: lib_Microsoft.Extensions.Configuration.dll.so => 38
	i32 u0x15e184df, ; 40: lib_System.Runtime.Loader.dll.so => 135
	i32 u0x16646418, ; 41: System.Net.ServicePoint.dll => 121
	i32 u0x16a510e1, ; 42: System.Threading.Thread.dll => 148
	i32 u0x16fe439a, ; 43: System.Memory.dll => 113
	i32 u0x17969339, ; 44: _Microsoft.Android.Resource.Designer => 34
	i32 u0x19f6996b, ; 45: sv/Microsoft.Maui.Controls.resources.dll => 26
	i32 u0x1a61054f, ; 46: System.Collections => 96
	i32 u0x1ae0ec2c, ; 47: Xamarin.AndroidX.Fragment.dll => 67
	i32 u0x1b317bfd, ; 48: System.Web.HttpUtility.dll => 150
	i32 u0x1b5932ea, ; 49: lib_Mono.Android.Runtime.dll.so => 159
	i32 u0x1b611806, ; 50: System.Runtime.Serialization.Primitives.dll => 138
	i32 u0x1bc6ffe7, ; 51: lib_Java.Interop.dll.so => 158
	i32 u0x1bff388e, ; 52: System.dll => 155
	i32 u0x1c78d08a, ; 53: lib_System.Private.Uri.dll.so => 128
	i32 u0x1dbae811, ; 54: System.ObjectModel => 127
	i32 u0x1dd2dc50, ; 55: id/Microsoft.Maui.Controls.resources.dll => 13
	i32 u0x1e092f31, ; 56: fi/Microsoft.Maui.Controls.resources.dll => 7
	i32 u0x1e9789de, ; 57: Microsoft.Extensions.Primitives.dll => 45
	i32 u0x1f6bf43d, ; 58: hi/Microsoft.Maui.Controls.resources => 10
	i32 u0x20216150, ; 59: Microsoft.Extensions.Logging => 42
	i32 u0x234b6fb2, ; 60: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i32 u0x2397454a, ; 61: lib_System.Collections.Specialized.dll.so => 95
	i32 u0x239cf51b, ; 62: CommunityToolkit.Maui => 36
	i32 u0x2459aaf0, ; 63: lib_System.Net.Sockets.dll.so => 122
	i32 u0x24f53b2c, ; 64: lib_Mopups.dll.so => 53
	i32 u0x2568904f, ; 65: Xamarin.AndroidX.CustomView => 65
	i32 u0x262d781c, ; 66: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i32 u0x2645b6c3, ; 67: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i32 u0x271c8cd5, ; 68: lib_Microsoft.Maui.Maps.dll.so => 52
	i32 u0x27787397, ; 69: System.Text.Encodings.Web.dll => 144
	i32 u0x27b53050, ; 70: lib_System.Data.Common.dll.so => 101
	i32 u0x2814a96c, ; 71: System.Collections.Concurrent => 92
	i32 u0x28607aa1, ; 72: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i32 u0x28bdabca, ; 73: System.Net.Security => 120
	i32 u0x2904cf94, ; 74: ca/Microsoft.Maui.Controls.resources.dll => 1
	i32 u0x29293ff5, ; 75: System.Xml.Linq.dll => 151
	i32 u0x29423679, ; 76: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 64
	i32 u0x2a1e8ecb, ; 77: ko/Microsoft.Maui.Controls.resources.dll => 16
	i32 u0x2a4afd4a, ; 78: de/Microsoft.Maui.Controls.resources.dll => 4
	i32 u0x2b07b160, ; 79: lib_Xamarin.GooglePlayServices.Maps.dll.so => 85
	i32 u0x2b15ed29, ; 80: System.Runtime.Loader.dll => 135
	i32 u0x2d445acd, ; 81: System.Net.Requests => 119
	i32 u0x2e394f87, ; 82: System.IO.Compression => 109
	i32 u0x2f0980eb, ; 83: Microsoft.Extensions.Options => 44
	i32 u0x2ff6fb9f, ; 84: System.Data.Common => 101
	i32 u0x30a0e95c, ; 85: lib_System.Threading.Thread.dll.so => 148
	i32 u0x311247b5, ; 86: System.Private.Uri.dll => 128
	i32 u0x3142c245, ; 87: StreetLightApp.dll => 90
	i32 u0x317d5b75, ; 88: System.IO.Compression.Brotli => 108
	i32 u0x3312831d, ; 89: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 66
	i32 u0x33e88be1, ; 90: ar/Microsoft.Maui.Controls.resources => 0
	i32 u0x35e25008, ; 91: System.ComponentModel.Primitives.dll => 97
	i32 u0x362c87fc, ; 92: Microsoft.Maui.Maps => 52
	i32 u0x3635f196, ; 93: lib_Xamarin.GooglePlayServices.Basement.dll.so => 84
	i32 u0x373f6a31, ; 94: tr/Microsoft.Maui.Controls.resources.dll => 28
	i32 u0x37ea9cd7, ; 95: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 70
	i32 u0x38d89c1d, ; 96: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 68
	i32 u0x38f24a24, ; 97: Newtonsoft.Json => 54
	i32 u0x3a2aaa1d, ; 98: System.Xml.XDocument => 153
	i32 u0x3b2c715c, ; 99: System.Collections.dll => 96
	i32 u0x3b3271e4, ; 100: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i32 u0x3b4797e5, ; 101: es/Microsoft.Maui.Controls.resources => 6
	i32 u0x3c5e5b62, ; 102: Xamarin.AndroidX.SavedState.dll => 78
	i32 u0x3cbffa41, ; 103: System.Drawing => 106
	i32 u0x3d548d92, ; 104: Microsoft.Extensions.DependencyInjection.Abstractions => 41
	i32 u0x3d5a6611, ; 105: da/Microsoft.Maui.Controls.resources.dll => 3
	i32 u0x3dbaaf8f, ; 106: Xamarin.AndroidX.AppCompat => 58
	i32 u0x3dc84a49, ; 107: System.Drawing.Primitives.dll => 105
	i32 u0x3e444eb4, ; 108: System.Linq.Expressions.dll => 111
	i32 u0x3ebd41f6, ; 109: lib_System.Collections.dll.so => 96
	i32 u0x3eea4db8, ; 110: lib_Microsoft.Extensions.Primitives.dll.so => 45
	i32 u0x408b17f4, ; 111: System.ComponentModel.TypeConverter => 98
	i32 u0x409e66d8, ; 112: Xamarin.Kotlin.StdLib => 87
	i32 u0x41761b2c, ; 113: System => 155
	i32 u0x417c4c3b, ; 114: lib_AsyncAwaitBestPractices.dll.so => 35
	i32 u0x42be2972, ; 115: lib_System.Text.Encodings.Web.dll.so => 144
	i32 u0x4393e151, ; 116: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i32 u0x444e5c8e, ; 117: lib_System.ComponentModel.TypeConverter.dll.so => 98
	i32 u0x4474042c, ; 118: lib_System.Numerics.Vectors.dll.so => 126
	i32 u0x44845810, ; 119: lib_System.Net.Http.dll.so => 114
	i32 u0x463a8801, ; 120: Xamarin.AndroidX.Navigation.Runtime.dll => 75
	i32 u0x464305ed, ; 121: fi/Microsoft.Maui.Controls.resources => 7
	i32 u0x47b79c15, ; 122: pl/Microsoft.Maui.Controls.resources.dll => 20
	i32 u0x480a69ad, ; 123: System.Diagnostics.Process => 103
	i32 u0x499b8219, ; 124: nb/Microsoft.Maui.Controls.resources.dll => 18
	i32 u0x4a0189ae, ; 125: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i32 u0x4a4cd262, ; 126: Xamarin.AndroidX.Collection.Jvm.dll => 61
	i32 u0x4ae97402, ; 127: lib_Microsoft.Maui.Graphics.dll.so => 51
	i32 u0x4b275854, ; 128: Xamarin.KotlinX.Serialization.Core.Jvm => 89
	i32 u0x4b863c7a, ; 129: lib_System.Private.Xml.Linq.dll.so => 129
	i32 u0x4d14ee2b, ; 130: Xamarin.AndroidX.DrawerLayout.dll => 66
	i32 u0x4eed2679, ; 131: System.Linq => 112
	i32 u0x50255dd9, ; 132: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i32 u0x50acdfd7, ; 133: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i32 u0x52114ed3, ; 134: Xamarin.AndroidX.SavedState => 78
	i32 u0x533678bd, ; 135: lib_System.Private.CoreLib.dll.so => 157
	i32 u0x53cefc50, ; 136: Xamarin.AndroidX.CoordinatorLayout => 62
	i32 u0x53f80ba6, ; 137: System.Runtime.Serialization.Formatters.dll => 137
	i32 u0x55ab7451, ; 138: Xamarin.AndroidX.Lifecycle.Common.Jvm => 68
	i32 u0x55b0fe2e, ; 139: lib_WatsonWebsocket.dll.so => 56
	i32 u0x55e55df2, ; 140: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 70
	i32 u0x568cd628, ; 141: System.Formats.Asn1.dll => 107
	i32 u0x56e7a7ad, ; 142: System.Net.Security.dll => 120
	i32 u0x5718a9ef, ; 143: System.Collections.Immutable.dll => 93
	i32 u0x57261233, ; 144: System.IO.Compression.dll => 109
	i32 u0x57924923, ; 145: Xamarin.AndroidX.AppCompat.AppCompatResources => 59
	i32 u0x57a5e912, ; 146: Microsoft.Extensions.Primitives => 45
	i32 u0x5833866d, ; 147: System.Collections.Immutable => 93
	i32 u0x583e844f, ; 148: System.IO.Compression.Brotli.dll => 108
	i32 u0x58fd6613, ; 149: hi/Microsoft.Maui.Controls.resources.dll => 10
	i32 u0x596b5b3a, ; 150: lib_System.Drawing.Primitives.dll.so => 105
	i32 u0x5a48cf6c, ; 151: el/Microsoft.Maui.Controls.resources.dll => 5
	i32 u0x5bf8ca0f, ; 152: System.Text.RegularExpressions.dll => 146
	i32 u0x5c7be408, ; 153: sk/Microsoft.Maui.Controls.resources.dll => 25
	i32 u0x5cabc9a4, ; 154: fr/Microsoft.Maui.Controls.resources => 8
	i32 u0x5e0b6fdc, ; 155: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 89
	i32 u0x5e33306d, ; 156: sv/Microsoft.Maui.Controls.resources => 26
	i32 u0x5e7321d2, ; 157: lib_System.ComponentModel.Primitives.dll.so => 97
	i32 u0x5ed5f779, ; 158: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i32 u0x6078995d, ; 159: System.Net.WebSockets.Client.dll => 124
	i32 u0x60b0136a, ; 160: Xamarin.AndroidX.Loader.dll => 72
	i32 u0x60d97228, ; 161: Xamarin.AndroidX.ViewPager2 => 81
	i32 u0x616edae3, ; 162: CommunityToolkit.Maui.Core.dll => 37
	i32 u0x6188ba7e, ; 163: Xamarin.AndroidX.CursorAdapter => 64
	i32 u0x61b9038d, ; 164: System.Net.Http.dll => 114
	i32 u0x61c036ca, ; 165: System.Text.RegularExpressions => 146
	i32 u0x62021776, ; 166: lib_System.IO.Compression.dll.so => 109
	i32 u0x620a8774, ; 167: lib_System.Xml.ReaderWriter.dll.so => 152
	i32 u0x62c6282e, ; 168: System.Runtime => 139
	i32 u0x62cec1a2, ; 169: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 88
	i32 u0x62d6ea10, ; 170: Xamarin.Google.Android.Material.dll => 82
	i32 u0x63635343, ; 171: Mopups.dll => 53
	i32 u0x63fca3d0, ; 172: System.Net.Primitives.dll => 118
	i32 u0x640c0103, ; 173: System.Net.WebSockets => 125
	i32 u0x641f3e5a, ; 174: System.Security.Cryptography => 141
	i32 u0x6715dc86, ; 175: Xamarin.AndroidX.CardView.dll => 60
	i32 u0x677cd287, ; 176: ro/Microsoft.Maui.Controls.resources.dll => 23
	i32 u0x67965db9, ; 177: lib_Microsoft.Maui.Controls.Maps.dll.so => 47
	i32 u0x68139a0d, ; 178: System.IO.Pipelines.dll => 110
	i32 u0x68f61ae4, ; 179: lib_System.Formats.Asn1.dll.so => 107
	i32 u0x690d4b7d, ; 180: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i32 u0x69239124, ; 181: System.Diagnostics.TraceSource.dll => 104
	i32 u0x693efa35, ; 182: lib_System.Net.WebHeaderCollection.dll.so => 123
	i32 u0x6947f945, ; 183: Xamarin.AndroidX.SwipeRefreshLayout => 79
	i32 u0x6988f147, ; 184: Microsoft.Extensions.Logging.dll => 42
	i32 u0x69f4f41d, ; 185: lib_Xamarin.AndroidX.AppCompat.dll.so => 58
	i32 u0x6a216153, ; 186: Mono.Android.Runtime.dll => 159
	i32 u0x6a96652d, ; 187: Xamarin.AndroidX.Fragment => 67
	i32 u0x6afaf338, ; 188: lib_System.Threading.dll.so => 149
	i32 u0x6b645ada, ; 189: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i32 u0x6bcd3296, ; 190: Xamarin.AndroidX.Loader => 72
	i32 u0x6be1e423, ; 191: nb/Microsoft.Maui.Controls.resources => 18
	i32 u0x6be29904, ; 192: lib_Xamarin.GooglePlayServices.Base.dll.so => 83
	i32 u0x6c111525, ; 193: Xamarin.Kotlin.StdLib.dll => 87
	i32 u0x6c13413e, ; 194: Xamarin.Google.Android.Material => 82
	i32 u0x6c652ce8, ; 195: Xamarin.AndroidX.Navigation.UI.dll => 76
	i32 u0x6c96614d, ; 196: hu/Microsoft.Maui.Controls.resources => 12
	i32 u0x6cbab720, ; 197: System.Text.Encoding.Extensions => 143
	i32 u0x6cc30c8c, ; 198: System.Runtime.Serialization.Formatters => 137
	i32 u0x6cff90ba, ; 199: Microsoft.Extensions.Logging.Abstractions.dll => 43
	i32 u0x6dcaebf7, ; 200: uk/Microsoft.Maui.Controls.resources.dll => 29
	i32 u0x6ec71a65, ; 201: System.Linq.Expressions => 111
	i32 u0x6f7a29e4, ; 202: System.Reflection.Primitives => 133
	i32 u0x7070c6c0, ; 203: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i32 u0x71c62d98, ; 204: Xamarin.GooglePlayServices.Basement => 84
	i32 u0x71dc7c8b, ; 205: System.Collections.NonGeneric.dll => 94
	i32 u0x72fcebde, ; 206: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 59
	i32 u0x731dd955, ; 207: lib_Mono.Android.dll.so => 160
	i32 u0x739bd4a8, ; 208: System.Private.Xml.Linq => 129
	i32 u0x73fbecbe, ; 209: lib_System.Memory.dll.so => 113
	i32 u0x74d743bf, ; 210: ja/Microsoft.Maui.Controls.resources => 15
	i32 u0x75533a5e, ; 211: Microsoft.Extensions.Configuration.dll => 38
	i32 u0x7554eac3, ; 212: AsyncAwaitBestPractices => 35
	i32 u0x781074ce, ; 213: hr/Microsoft.Maui.Controls.resources => 11
	i32 u0x78b622b1, ; 214: ar/Microsoft.Maui.Controls.resources.dll => 0
	i32 u0x7970be4f, ; 215: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i32 u0x79d00016, ; 216: it/Microsoft.Maui.Controls.resources => 14
	i32 u0x79eb68ee, ; 217: System.Private.Xml => 130
	i32 u0x7a80bd4e, ; 218: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 69
	i32 u0x7b350579, ; 219: lib__Microsoft.Android.Resource.Designer.dll.so => 34
	i32 u0x7b6f419e, ; 220: System.Diagnostics.TraceSource => 104
	i32 u0x7bf8cdab, ; 221: System.Runtime.dll => 139
	i32 u0x7c51ebd4, ; 222: lib_System.Net.HttpListener.dll.so => 115
	i32 u0x7c9bf920, ; 223: System.Numerics.Vectors => 126
	i32 u0x7ec9ffe9, ; 224: System.Console => 100
	i32 u0x7eed5835, ; 225: Xamarin.GooglePlayServices.Base.dll => 83
	i32 u0x7fb38cd2, ; 226: System.Collections.Specialized => 95
	i32 u0x7fc7a41e, ; 227: System.Xml.XmlSerializer.dll => 154
	i32 u0x7fdcdc37, ; 228: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i32 u0x8030853e, ; 229: ko/Microsoft.Maui.Controls.resources => 16
	i32 u0x8044e1bd, ; 230: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i32 u0x80bd55ad, ; 231: Microsoft.Maui => 49
	i32 u0x80f2f56e, ; 232: lib_System.Runtime.Serialization.Formatters.dll.so => 137
	i32 u0x810c11c2, ; 233: ro/Microsoft.Maui.Controls.resources => 23
	i32 u0x816751d8, ; 234: lib_System.Diagnostics.DiagnosticSource.dll.so => 102
	i32 u0x820d22b3, ; 235: Microsoft.Extensions.Options.dll => 44
	i32 u0x82a8237c, ; 236: Microsoft.Extensions.Logging.Abstractions => 43
	i32 u0x82b6c85e, ; 237: System.ObjectModel.dll => 127
	i32 u0x82bb5429, ; 238: lib_System.Linq.Expressions.dll.so => 111
	i32 u0x83323b38, ; 239: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 88
	i32 u0x8334206b, ; 240: System.Net.Http => 114
	i32 u0x857e4dd2, ; 241: lib_System.Net.WebSockets.dll.so => 125
	i32 u0x8628f1a4, ; 242: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i32 u0x86bba59b, ; 243: lib_Microsoft.Maui.Controls.dll.so => 46
	i32 u0x871c9c1b, ; 244: Microsoft.Extensions.Configuration.Abstractions => 39
	i32 u0x875633cc, ; 245: fr/Microsoft.Maui.Controls.resources.dll => 8
	i32 u0x87a1a22b, ; 246: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i32 u0x87e25095, ; 247: Xamarin.AndroidX.RecyclerView.dll => 77
	i32 u0x87e7fdbb, ; 248: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i32 u0x881f94da, ; 249: lib_netstandard.dll.so => 156
	i32 u0x8873eb17, ; 250: th/Microsoft.Maui.Controls.resources => 27
	i32 u0x88d8bfaa, ; 251: System.Net.Sockets => 122
	i32 u0x89461bcb, ; 252: Microsoft.Maui.Controls.Maps.dll => 47
	i32 u0x896b7878, ; 253: System.Private.CoreLib.dll => 157
	i32 u0x8c20c628, ; 254: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i32 u0x8c20f140, ; 255: lib_System.Console.dll.so => 100
	i32 u0x8c40e0db, ; 256: System.Net.Primitives => 118
	i32 u0x8d24e767, ; 257: System.Xml.ReaderWriter.dll => 152
	i32 u0x8d3fac99, ; 258: tr/Microsoft.Maui.Controls.resources => 28
	i32 u0x8d52b2e2, ; 259: Microsoft.Extensions.Configuration => 38
	i32 u0x8dcb0101, ; 260: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 74
	i32 u0x8e02310f, ; 261: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i32 u0x8e114655, ; 262: System.Security.Principal.Windows.dll => 142
	i32 u0x8f24faee, ; 263: System.Web.HttpUtility => 150
	i32 u0x8f8c64e2, ; 264: lib_System.Private.Xml.dll.so => 130
	i32 u0x905caa9d, ; 265: nl/Microsoft.Maui.Controls.resources => 19
	i32 u0x90e50509, ; 266: lib_System.Reflection.Primitives.dll.so => 133
	i32 u0x911615a7, ; 267: lib_Xamarin.AndroidX.Fragment.dll.so => 67
	i32 u0x912896e5, ; 268: System.Console.dll => 100
	i32 u0x928c75ca, ; 269: System.Net.Sockets.dll => 122
	i32 u0x93554fdc, ; 270: netstandard.dll => 156
	i32 u0x93918882, ; 271: Java.Interop.dll => 158
	i32 u0x93dba8a1, ; 272: Microsoft.Maui.Controls => 46
	i32 u0x94147f61, ; 273: System.Net.ServicePoint => 121
	i32 u0x9438d78e, ; 274: lib_System.Text.Json.dll.so => 145
	i32 u0x94a1db18, ; 275: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i32 u0x9593ae7f, ; 276: lib_Xamarin.AndroidX.SavedState.dll.so => 78
	i32 u0x963ac2da, ; 277: sk/Microsoft.Maui.Controls.resources => 25
	i32 u0x96bea474, ; 278: lib_Microsoft.Maui.Controls.Xaml.dll.so => 48
	i32 u0x974b89a2, ; 279: System.Reflection.Emit.Lightweight.dll => 132
	i32 u0x98ba5a04, ; 280: Microsoft.CSharp => 91
	i32 u0x98e90c02, ; 281: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 86
	i32 u0x9930ee42, ; 282: System.Text.Encodings.Web => 144
	i32 u0x9a1756ac, ; 283: System.Text.Encoding.Extensions.dll => 143
	i32 u0x9b24ab96, ; 284: lib_System.Runtime.Serialization.Primitives.dll.so => 138
	i32 u0x9b500441, ; 285: Xamarin.KotlinX.Coroutines.Core.Jvm => 88
	i32 u0x9bfe3a41, ; 286: System.Private.Xml.dll => 130
	i32 u0x9c375496, ; 287: Xamarin.AndroidX.CursorAdapter.dll => 64
	i32 u0x9c96ac4c, ; 288: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 76
	i32 u0x9e78dac1, ; 289: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 71
	i32 u0x9ec4cf01, ; 290: System.Runtime.Loader => 135
	i32 u0x9ecf752a, ; 291: System.Xml.XDocument.dll => 153
	i32 u0x9ee22cc0, ; 292: System.Drawing.Primitives => 105
	i32 u0x9f7ea921, ; 293: lib_System.Runtime.InteropServices.dll.so => 134
	i32 u0x9f8c6f40, ; 294: System.Data.Common.dll => 101
	i32 u0xa0fb56af, ; 295: lib_System.Text.RegularExpressions.dll.so => 146
	i32 u0xa1fd7d9f, ; 296: System.Security.Claims => 140
	i32 u0xa25c90e5, ; 297: lib_Xamarin.AndroidX.Core.dll.so => 63
	i32 u0xa262a30f, ; 298: System.Runtime.Numerics.dll => 136
	i32 u0xa2ce8457, ; 299: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i32 u0xa2e0939b, ; 300: Xamarin.AndroidX.Activity => 57
	i32 u0xa30769e5, ; 301: System.Threading.Channels => 147
	i32 u0xa32eb6f0, ; 302: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 59
	i32 u0xa3c818c7, ; 303: lib_System.Net.WebSockets.Client.dll.so => 124
	i32 u0xa4672f3b, ; 304: Microsoft.Maui.Controls.Xaml => 48
	i32 u0xa493aa02, ; 305: lib_System.Collections.Concurrent.dll.so => 92
	i32 u0xa4caf7a7, ; 306: Microsoft.Maui.dll => 49
	i32 u0xa4e79dfd, ; 307: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 70
	i32 u0xa5a0a402, ; 308: Xamarin.AndroidX.ViewPager.dll => 80
	i32 u0xa5b67c07, ; 309: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 68
	i32 u0xa5c5753c, ; 310: lib_System.Collections.Immutable.dll.so => 93
	i32 u0xa668c988, ; 311: lib_System.Net.NameResolution.dll.so => 116
	i32 u0xa7008e0b, ; 312: Microsoft.Maui.Graphics => 51
	i32 u0xa7042ae3, ; 313: uk/Microsoft.Maui.Controls.resources => 29
	i32 u0xa741ef0b, ; 314: es/Microsoft.Maui.Controls.resources.dll => 6
	i32 u0xa744f665, ; 315: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 75
	i32 u0xa78103bc, ; 316: Xamarin.AndroidX.CoordinatorLayout.dll => 62
	i32 u0xa81b119f, ; 317: lib_System.Security.Cryptography.dll.so => 141
	i32 u0xa8c61dcb, ; 318: nl/Microsoft.Maui.Controls.resources.dll => 19
	i32 u0xa9b829f7, ; 319: Xamarin.GooglePlayServices.Base => 83
	i32 u0xaa107fc4, ; 320: Xamarin.AndroidX.ViewPager => 80
	i32 u0xaa4e51ff, ; 321: el/Microsoft.Maui.Controls.resources => 5
	i32 u0xaa8a4878, ; 322: Microsoft.Maui.Essentials => 50
	i32 u0xaaf9aad7, ; 323: CommunityToolkit.Maui.Core => 37
	i32 u0xabbc23e8, ; 324: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 89
	i32 u0xabdea79a, ; 325: ru/Microsoft.Maui.Controls.resources => 24
	i32 u0xace7ba82, ; 326: lib_System.Security.Principal.Windows.dll.so => 142
	i32 u0xad6f1e8a, ; 327: System.Private.CoreLib => 157
	i32 u0xaddb6d38, ; 328: Xamarin.AndroidX.ViewPager2.dll => 81
	i32 u0xae037813, ; 329: System.Numerics.Vectors.dll => 126
	i32 u0xaeb2d8a5, ; 330: lib_Microsoft.Extensions.Options.dll.so => 44
	i32 u0xb0682092, ; 331: System.ComponentModel.dll => 99
	i32 u0xb0ed41f3, ; 332: System.Security.Principal.Windows => 142
	i32 u0xb18af942, ; 333: Xamarin.AndroidX.DrawerLayout => 66
	i32 u0xb1a434a2, ; 334: lib_System.Xml.Linq.dll.so => 151
	i32 u0xb223fa8c, ; 335: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i32 u0xb3d4efc5, ; 336: Xamarin.GooglePlayServices.Maps => 85
	i32 u0xb514b305, ; 337: _Microsoft.Android.Resource.Designer.dll => 34
	i32 u0xb63fa9f0, ; 338: Xamarin.AndroidX.Navigation.Common => 73
	i32 u0xb646e70c, ; 339: Xamarin.GooglePlayServices.Tasks => 86
	i32 u0xb65adef9, ; 340: Mono.Android.Runtime => 159
	i32 u0xb65daa69, ; 341: lib_StreetLightApp.dll.so => 90
	i32 u0xb660be12, ; 342: System.ComponentModel.Primitives => 97
	i32 u0xb6a153b2, ; 343: lib_Xamarin.AndroidX.ViewPager2.dll.so => 81
	i32 u0xb76be845, ; 344: hu/Microsoft.Maui.Controls.resources.dll => 12
	i32 u0xb8c22b7f, ; 345: System.Security.Claims.dll => 140
	i32 u0xb8fd311b, ; 346: System.Formats.Asn1 => 107
	i32 u0xbaa520e7, ; 347: lib_System.ObjectModel.dll.so => 127
	i32 u0xbc4c6465, ; 348: System.Reflection.Primitives.dll => 133
	i32 u0xbc98c93d, ; 349: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 61
	i32 u0xbd113355, ; 350: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 73
	i32 u0xbd78b0c8, ; 351: Xamarin.AndroidX.Navigation.Fragment.dll => 74
	i32 u0xbff2e236, ; 352: System.Threading => 149
	i32 u0xc00e375b, ; 353: lib_Newtonsoft.Json.dll.so => 54
	i32 u0xc08d007e, ; 354: Xamarin.GooglePlayServices.Basement.dll => 84
	i32 u0xc1abc74d, ; 355: RestSharp.dll => 55
	i32 u0xc235e84d, ; 356: Xamarin.AndroidX.CardView => 60
	i32 u0xc3428433, ; 357: lib_System.Reflection.Emit.ILGeneration.dll.so => 131
	i32 u0xc591efe9, ; 358: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 39
	i32 u0xc5b097e4, ; 359: System.Net.Requests.dll => 119
	i32 u0xc5b776df, ; 360: Xamarin.AndroidX.CustomView.dll => 65
	i32 u0xc774da4f, ; 361: Xamarin.AndroidX.Navigation.Runtime => 75
	i32 u0xc821fc10, ; 362: lib_System.ComponentModel.dll.so => 99
	i32 u0xc82afec1, ; 363: System.Text.Json => 145
	i32 u0xc86c06e3, ; 364: Xamarin.AndroidX.Core => 63
	i32 u0xc8a662e9, ; 365: Java.Interop => 158
	i32 u0xc8d10307, ; 366: lib_System.Diagnostics.TraceSource.dll.so => 104
	i32 u0xc92a6809, ; 367: Xamarin.AndroidX.RecyclerView => 77
	i32 u0xcb5af55c, ; 368: lib_System.Reflection.Emit.Lightweight.dll.so => 132
	i32 u0xcc5af6ee, ; 369: Microsoft.Extensions.DependencyInjection.dll => 40
	i32 u0xcc7d82b4, ; 370: netstandard => 156
	i32 u0xce3fa116, ; 371: lib_System.Diagnostics.Process.dll.so => 103
	i32 u0xce70fda2, ; 372: hr/Microsoft.Maui.Controls.resources.dll => 11
	i32 u0xcef19b37, ; 373: System.ComponentModel.TypeConverter.dll => 98
	i32 u0xcf3163e6, ; 374: Mono.Android => 160
	i32 u0xcf663a21, ; 375: ru/Microsoft.Maui.Controls.resources.dll => 24
	i32 u0xcfa20c36, ; 376: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 79
	i32 u0xcfbaacae, ; 377: System.Text.Json.dll => 145
	i32 u0xd0a98ee2, ; 378: Microsoft.Maui.Controls.Maps => 47
	i32 u0xd128d608, ; 379: System.Xml.Linq => 151
	i32 u0xd2ff69f1, ; 380: System.Net.HttpListener => 115
	i32 u0xd328ac54, ; 381: vi/Microsoft.Maui.Controls.resources => 30
	i32 u0xd4045e1b, ; 382: lib_System.dll.so => 155
	i32 u0xd457e5c9, ; 383: lib_Microsoft.CSharp.dll.so => 91
	i32 u0xd45fd3d5, ; 384: WatsonWebsocket.dll => 56
	i32 u0xd622b752, ; 385: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i32 u0xd664cdf2, ; 386: de/Microsoft.Maui.Controls.resources => 4
	i32 u0xd67a52b3, ; 387: System.Net.WebSockets.Client => 124
	i32 u0xd715a361, ; 388: System.Linq.dll => 112
	i32 u0xd77927f1, ; 389: StreetLightApp => 90
	i32 u0xd7f95f5a, ; 390: da/Microsoft.Maui.Controls.resources => 3
	i32 u0xd889aee8, ; 391: lib_System.Threading.Channels.dll.so => 147
	i32 u0xd8bba49d, ; 392: lib_Xamarin.AndroidX.RecyclerView.dll.so => 77
	i32 u0xd90e5f5a, ; 393: Xamarin.AndroidX.Lifecycle.LiveData.Core => 69
	i32 u0xd930cda0, ; 394: Xamarin.AndroidX.Navigation.Fragment => 74
	i32 u0xd96cf6f7, ; 395: pt-BR/Microsoft.Maui.Controls.resources => 21
	i32 u0xd9f65f5e, ; 396: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i32 u0xd9fdda56, ; 397: Microsoft.Extensions.Configuration.Abstractions.dll => 39
	i32 u0xda2f27df, ; 398: System.Net.NetworkInformation => 117
	i32 u0xda4773dd, ; 399: he/Microsoft.Maui.Controls.resources => 9
	i32 u0xdae8aa5e, ; 400: Mono.Android.dll => 160
	i32 u0xdbb50d93, ; 401: ms/Microsoft.Maui.Controls.resources => 17
	i32 u0xdc5370c5, ; 402: lib_System.Web.HttpUtility.dll.so => 150
	i32 u0xdc68940c, ; 403: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i32 u0xde068c70, ; 404: Xamarin.AndroidX.Navigation.Common.dll => 73
	i32 u0xde7354ab, ; 405: System.Net.NameResolution => 116
	i32 u0xdf6f3870, ; 406: System.Diagnostics.DiagnosticSource => 102
	i32 u0xe0dec2ee, ; 407: lib_CommunityToolkit.Maui.dll.so => 36
	i32 u0xe13414bb, ; 408: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i32 u0xe1a41194, ; 409: lib_System.Xml.XDocument.dll.so => 153
	i32 u0xe1f0a5d8, ; 410: lib_Xamarin.AndroidX.ViewPager.dll.so => 80
	i32 u0xe2098b0b, ; 411: System.Collections.NonGeneric => 94
	i32 u0xe2197fa1, ; 412: AsyncAwaitBestPractices.dll => 35
	i32 u0xe250cda6, ; 413: lib_Microsoft.Extensions.Logging.dll.so => 42
	i32 u0xe2513246, ; 414: lib_System.Runtime.Numerics.dll.so => 136
	i32 u0xe2a3f2e8, ; 415: System.Collections.Specialized.dll => 95
	i32 u0xe34ee011, ; 416: lib_System.IO.Pipelines.dll.so => 110
	i32 u0xe37a36df, ; 417: RestSharp => 55
	i32 u0xe3886bf7, ; 418: CommunityToolkit.Maui.dll => 36
	i32 u0xe3c7860c, ; 419: lib_System.Security.Claims.dll.so => 140
	i32 u0xe3df9d2b, ; 420: System.Security.Cryptography.dll => 141
	i32 u0xe4fab729, ; 421: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 41
	i32 u0xe56ef253, ; 422: System.Runtime.InteropServices.dll => 134
	i32 u0xe625b819, ; 423: lib_Xamarin.AndroidX.CardView.dll.so => 60
	i32 u0xe6b14171, ; 424: System.Net.HttpListener.dll => 115
	i32 u0xe797fcc1, ; 425: System.Net.WebHeaderCollection.dll => 123
	i32 u0xe7dc15ff, ; 426: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i32 u0xe839deed, ; 427: System.Collections.Concurrent.dll => 92
	i32 u0xe843daa0, ; 428: Xamarin.AndroidX.Core.dll => 63
	i32 u0xe90fdb70, ; 429: Xamarin.AndroidX.Collection.Jvm => 61
	i32 u0xe99f7d24, ; 430: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i32 u0xea213423, ; 431: System.Xml.ReaderWriter => 152
	i32 u0xea4fb52e, ; 432: Xamarin.AndroidX.Navigation.UI => 76
	i32 u0xeab81858, ; 433: lib_Microsoft.Maui.Essentials.dll.so => 50
	i32 u0xeaf598f6, ; 434: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 43
	i32 u0xebb0254b, ; 435: lib_System.Net.NetworkInformation.dll.so => 117
	i32 u0xebc66336, ; 436: Xamarin.AndroidX.AppCompat.dll => 58
	i32 u0xeca1adaf, ; 437: Xamarin.GooglePlayServices.Tasks.dll => 86
	i32 u0xed1090ae, ; 438: lib_System.Net.Primitives.dll.so => 118
	i32 u0xed409aea, ; 439: th/Microsoft.Maui.Controls.resources.dll => 27
	i32 u0xed96d41f, ; 440: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 62
	i32 u0xedadd6e2, ; 441: he/Microsoft.Maui.Controls.resources.dll => 9
	i32 u0xedf6669b, ; 442: lib_System.Drawing.dll.so => 106
	i32 u0xee9f991d, ; 443: System.Diagnostics.Process.dll => 103
	i32 u0xefd01a89, ; 444: System.IO.Pipelines => 110
	i32 u0xeff49a63, ; 445: System.Memory => 113
	i32 u0xeff49c4a, ; 446: lib_System.Text.Encoding.Extensions.dll.so => 143
	i32 u0xf04057de, ; 447: Mopups => 53
	i32 u0xf121f953, ; 448: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 69
	i32 u0xf1304331, ; 449: Microsoft.Maui.Controls.Xaml.dll => 48
	i32 u0xf1676aaa, ; 450: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i32 u0xf1ad867b, ; 451: System.Reflection.Emit.ILGeneration => 131
	i32 u0xf27f60d1, ; 452: System.Private.Xml.Linq.dll => 129
	i32 u0xf29c5384, ; 453: id/Microsoft.Maui.Controls.resources => 13
	i32 u0xf2ce3c98, ; 454: System.Threading.dll => 149
	i32 u0xf2dd3fc4, ; 455: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i32 u0xf323e0a6, ; 456: lib_Xamarin.Kotlin.StdLib.dll.so => 87
	i32 u0xf40add04, ; 457: Microsoft.Maui.Essentials.dll => 50
	i32 u0xf45985cf, ; 458: System.Drawing.dll => 106
	i32 u0xf462c30d, ; 459: System.Private.Uri => 128
	i32 u0xf48143e5, ; 460: pt/Microsoft.Maui.Controls.resources.dll => 22
	i32 u0xf5185c24, ; 461: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i32 u0xf53cb11d, ; 462: lib_System.Net.Security.dll.so => 120
	i32 u0xf5861a4f, ; 463: pl/Microsoft.Maui.Controls.resources => 20
	i32 u0xf5e94e90, ; 464: ms/Microsoft.Maui.Controls.resources.dll => 17
	i32 u0xf5f4f1f0, ; 465: Microsoft.Extensions.DependencyInjection => 40
	i32 u0xf5fdf056, ; 466: lib_Microsoft.Extensions.DependencyInjection.dll.so => 40
	i32 u0xf73be021, ; 467: System.Reflection.Emit.ILGeneration.dll => 131
	i32 u0xf798e6c6, ; 468: WatsonWebsocket => 56
	i32 u0xf7e95c85, ; 469: System.Xml.XmlSerializer => 154
	i32 u0xf86129d4, ; 470: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i32 u0xf93ba7d4, ; 471: System.Runtime.Serialization.Primitives => 138
	i32 u0xf94a8f86, ; 472: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 71
	i32 u0xf9cd7515, ; 473: Microsoft.Maui.Maps.dll => 52
	i32 u0xfa50891f, ; 474: lib_System.Linq.dll.so => 112
	i32 u0xfb0af295, ; 475: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i32 u0xfb1dad5d, ; 476: System.Diagnostics.DiagnosticSource.dll => 102
	i32 u0xfbc4b67c, ; 477: lib_System.IO.Compression.Brotli.dll.so => 108
	i32 u0xfc5f7d36, ; 478: pt/Microsoft.Maui.Controls.resources => 22
	i32 u0xfea12dee, ; 479: Microsoft.Maui.Controls.dll => 46
	i32 u0xfecef6ea, ; 480: System.Runtime.Numerics => 136
	i32 u0xfeff2639, ; 481: Xamarin.GooglePlayServices.Maps.dll => 85
	i32 u0xffd4917f ; 482: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 71
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [483 x i32] [
	i32 117, i32 119, i32 116, i32 72, i32 154, i32 41, i32 54, i32 125,
	i32 29, i32 148, i32 49, i32 1, i32 51, i32 94, i32 31, i32 134,
	i32 147, i32 123, i32 57, i32 55, i32 79, i32 30, i32 82, i32 20,
	i32 30, i32 121, i32 31, i32 99, i32 91, i32 65, i32 18, i32 132,
	i32 2, i32 25, i32 57, i32 139, i32 15, i32 14, i32 2, i32 38,
	i32 135, i32 121, i32 148, i32 113, i32 34, i32 26, i32 96, i32 67,
	i32 150, i32 159, i32 138, i32 158, i32 155, i32 128, i32 127, i32 13,
	i32 7, i32 45, i32 10, i32 42, i32 21, i32 95, i32 36, i32 122,
	i32 53, i32 65, i32 4, i32 37, i32 52, i32 144, i32 101, i32 92,
	i32 21, i32 120, i32 1, i32 151, i32 64, i32 16, i32 4, i32 85,
	i32 135, i32 119, i32 109, i32 44, i32 101, i32 148, i32 128, i32 90,
	i32 108, i32 66, i32 0, i32 97, i32 52, i32 84, i32 28, i32 70,
	i32 68, i32 54, i32 153, i32 96, i32 32, i32 6, i32 78, i32 106,
	i32 41, i32 3, i32 58, i32 105, i32 111, i32 96, i32 45, i32 98,
	i32 87, i32 155, i32 35, i32 144, i32 27, i32 98, i32 126, i32 114,
	i32 75, i32 7, i32 20, i32 103, i32 18, i32 10, i32 61, i32 51,
	i32 89, i32 129, i32 66, i32 112, i32 11, i32 1, i32 78, i32 157,
	i32 62, i32 137, i32 68, i32 56, i32 70, i32 107, i32 120, i32 93,
	i32 109, i32 59, i32 45, i32 93, i32 108, i32 10, i32 105, i32 5,
	i32 146, i32 25, i32 8, i32 89, i32 26, i32 97, i32 33, i32 124,
	i32 72, i32 81, i32 37, i32 64, i32 114, i32 146, i32 109, i32 152,
	i32 139, i32 88, i32 82, i32 53, i32 118, i32 125, i32 141, i32 60,
	i32 23, i32 47, i32 110, i32 107, i32 33, i32 104, i32 123, i32 79,
	i32 42, i32 58, i32 159, i32 67, i32 149, i32 8, i32 72, i32 18,
	i32 83, i32 87, i32 82, i32 76, i32 12, i32 143, i32 137, i32 43,
	i32 29, i32 111, i32 133, i32 32, i32 84, i32 94, i32 59, i32 160,
	i32 129, i32 113, i32 15, i32 38, i32 35, i32 11, i32 0, i32 9,
	i32 14, i32 130, i32 69, i32 34, i32 104, i32 139, i32 115, i32 126,
	i32 100, i32 83, i32 95, i32 154, i32 16, i32 16, i32 17, i32 49,
	i32 137, i32 23, i32 102, i32 44, i32 43, i32 127, i32 111, i32 88,
	i32 114, i32 125, i32 24, i32 46, i32 39, i32 8, i32 14, i32 77,
	i32 19, i32 156, i32 27, i32 122, i32 47, i32 157, i32 7, i32 100,
	i32 118, i32 152, i32 28, i32 38, i32 74, i32 0, i32 142, i32 150,
	i32 130, i32 19, i32 133, i32 67, i32 100, i32 122, i32 156, i32 158,
	i32 46, i32 121, i32 145, i32 13, i32 78, i32 25, i32 48, i32 132,
	i32 91, i32 86, i32 144, i32 143, i32 138, i32 88, i32 130, i32 64,
	i32 76, i32 71, i32 135, i32 153, i32 105, i32 134, i32 101, i32 146,
	i32 140, i32 63, i32 136, i32 6, i32 57, i32 147, i32 59, i32 124,
	i32 48, i32 92, i32 49, i32 70, i32 80, i32 68, i32 93, i32 116,
	i32 51, i32 29, i32 6, i32 75, i32 62, i32 141, i32 19, i32 83,
	i32 80, i32 5, i32 50, i32 37, i32 89, i32 24, i32 142, i32 157,
	i32 81, i32 126, i32 44, i32 99, i32 142, i32 66, i32 151, i32 2,
	i32 85, i32 34, i32 73, i32 86, i32 159, i32 90, i32 97, i32 81,
	i32 12, i32 140, i32 107, i32 127, i32 133, i32 61, i32 73, i32 74,
	i32 149, i32 54, i32 84, i32 55, i32 60, i32 131, i32 39, i32 119,
	i32 65, i32 75, i32 99, i32 145, i32 63, i32 158, i32 104, i32 77,
	i32 132, i32 40, i32 156, i32 103, i32 11, i32 98, i32 160, i32 24,
	i32 79, i32 145, i32 47, i32 151, i32 115, i32 30, i32 155, i32 91,
	i32 56, i32 23, i32 4, i32 124, i32 112, i32 90, i32 3, i32 147,
	i32 77, i32 69, i32 74, i32 21, i32 5, i32 39, i32 117, i32 9,
	i32 160, i32 17, i32 150, i32 33, i32 73, i32 116, i32 102, i32 36,
	i32 12, i32 153, i32 80, i32 94, i32 35, i32 42, i32 136, i32 95,
	i32 110, i32 55, i32 36, i32 140, i32 141, i32 41, i32 134, i32 60,
	i32 115, i32 123, i32 32, i32 92, i32 63, i32 61, i32 28, i32 152,
	i32 76, i32 50, i32 43, i32 117, i32 58, i32 86, i32 118, i32 27,
	i32 62, i32 9, i32 106, i32 103, i32 110, i32 113, i32 143, i32 53,
	i32 69, i32 48, i32 3, i32 131, i32 129, i32 13, i32 149, i32 15,
	i32 87, i32 50, i32 106, i32 128, i32 22, i32 22, i32 120, i32 20,
	i32 17, i32 40, i32 40, i32 131, i32 56, i32 154, i32 26, i32 138,
	i32 71, i32 52, i32 112, i32 31, i32 102, i32 108, i32 22, i32 46,
	i32 136, i32 85, i32 71
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
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

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
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
