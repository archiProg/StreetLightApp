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

@assembly_image_cache = dso_local local_unnamed_addr global [330 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [990 x i32] [
	i32 u0x0027eb9e, ; 0: System.Net.NetworkInformation.dll => 69
	i32 u0x00345a11, ; 1: lib_System.Net.Requests.dll.so => 73
	i32 u0x009b21bb, ; 2: System.Net.NameResolution.dll => 68
	i32 u0x00c8cc5d, ; 3: lib_Xamarin.AndroidX.Loader.dll.so => 248
	i32 u0x00e0bbf7, ; 4: lib_System.Xml.XmlSerializer.dll.so => 163
	i32 u0x00efe298, ; 5: System.Runtime.Intrinsics.dll => 109
	i32 u0x0119bc86, ; 6: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 181
	i32 u0x01f2c4e1, ; 7: Xamarin.AndroidX.Lifecycle.Runtime => 240
	i32 u0x0211b5dc, ; 8: Xamarin.Google.Guava.ListenableFuture.dll => 276
	i32 u0x02139ac3, ; 9: System.IO.FileSystem.DriveInfo => 48
	i32 u0x0254c520, ; 10: Newtonsoft.Json.dll => 195
	i32 u0x025a8054, ; 11: System.Net.WebSockets.dll => 81
	i32 u0x02664405, ; 12: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 320
	i32 u0x028aa24d, ; 13: System.Threading.Thread => 146
	i32 u0x02bda0f5, ; 14: Xamarin.KotlinX.AtomicFU.Jvm => 285
	i32 u0x03358480, ; 15: lib_Microsoft.Maui.dll.so => 190
	i32 u0x0335cdbc, ; 16: ca/Microsoft.Maui.Controls.resources => 292
	i32 u0x03f75868, ; 17: System.Diagnostics.StackTrace => 30
	i32 u0x0410f24b, ; 18: System.Security.Cryptography.Primitives => 125
	i32 u0x044bb714, ; 19: Microsoft.Maui.Graphics.dll => 192
	i32 u0x04e7b0a1, ; 20: System.Runtime.CompilerServices.VisualC.dll => 103
	i32 u0x056606a6, ; 21: lib_System.Collections.NonGeneric.dll.so => 10
	i32 u0x060d4943, ; 22: Xamarin.AndroidX.SlidingPaneLayout => 259
	i32 u0x065dd880, ; 23: lib_System.Linq.Queryable.dll.so => 61
	i32 u0x06c2cd46, ; 24: zh-HK/Microsoft.Maui.Controls.resources => 322
	i32 u0x06e4e181, ; 25: lib_Xamarin.Google.Guava.ListenableFuture.dll.so => 276
	i32 u0x06ee56d3, ; 26: lib_System.Net.Mail.dll.so => 67
	i32 u0x06ffddbc, ; 27: System.Runtime.InteropServices => 108
	i32 u0x072f9521, ; 28: Xamarin.AndroidX.SlidingPaneLayout.dll => 259
	i32 u0x074aea82, ; 29: System.Threading.Channels.dll => 140
	i32 u0x0772c6a7, ; 30: lib_System.Diagnostics.TextWriterTraceListener.dll.so => 31
	i32 u0x0881c32f, ; 31: System.Net.WebHeaderCollection => 78
	i32 u0x08f064cf, ; 32: System.Security.Cryptography.Primitives.dll => 125
	i32 u0x097ed3c0, ; 33: System.ComponentModel.Annotations => 13
	i32 u0x098905a2, ; 34: lib_Xamarin.AndroidX.Concurrent.Futures.dll.so => 216
	i32 u0x09d975c3, ; 35: Xamarin.AndroidX.Collection.dll => 213
	i32 u0x09e60a6e, ; 36: Xamarin.KotlinX.AtomicFU.dll => 284
	i32 u0x0a0c2bd0, ; 37: lib_Xamarin.AndroidX.Activity.dll.so => 202
	i32 u0x0a81994f, ; 38: System.ServiceProcess => 133
	i32 u0x0ad19b61, ; 39: lib_RestSharp.dll.so => 196
	i32 u0x0ade3a75, ; 40: Xamarin.AndroidX.SwipeRefreshLayout.dll => 261
	i32 u0x0ae43932, ; 41: lib_Xamarin.AndroidX.Tracing.Tracing.dll.so => 262
	i32 u0x0aee6a3d, ; 42: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 321
	i32 u0x0aeedc53, ; 43: lib_Xamarin.Google.Android.Material.dll.so => 271
	i32 u0x0afca281, ; 44: System.ValueTuple.dll => 152
	i32 u0x0b0de1c3, ; 45: lib_System.Xml.XPath.XDocument.dll.so => 160
	i32 u0x0b63b1e1, ; 46: lib_System.Net.Http.Json.dll.so => 64
	i32 u0x0b721a36, ; 47: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 311
	i32 u0x0ba65f85, ; 48: vi/Microsoft.Maui.Controls.resources.dll => 321
	i32 u0x0ba8e231, ; 49: lib_System.Net.ServicePoint.dll.so => 75
	i32 u0x0be195c3, ; 50: zh-HK/Microsoft.Maui.Controls.resources.dll => 322
	i32 u0x0c38ff48, ; 51: System.ComponentModel => 18
	i32 u0x0c5df1c2, ; 52: lib_Microsoft.VisualStudio.DesignTools.XamlTapContract.dll.so => 328
	i32 u0x0c7b2e71, ; 53: Xamarin.AndroidX.Browser.dll => 211
	i32 u0x0cfa66a6, ; 54: lib_System.IO.Compression.FileSystem.dll.so => 44
	i32 u0x0d1f8edb, ; 55: System.Diagnostics.Debug => 26
	i32 u0x0d73bff4, ; 56: lib_Microsoft.Extensions.Logging.Debug.dll.so => 184
	i32 u0x0dc10265, ; 57: Microsoft.CSharp.dll => 1
	i32 u0x0dc2edec, ; 58: lib_Xamarin.AndroidX.Core.ViewTree.dll.so => 222
	i32 u0x0dc2f416, ; 59: lib_Xamarin.AndroidX.CustomView.dll.so => 224
	i32 u0x0dcb05c4, ; 60: System.Linq.Parallel => 60
	i32 u0x0dd133ce, ; 61: System.Globalization => 42
	i32 u0x0e762ada, ; 62: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 309
	i32 u0x0eb2f8c5, ; 63: System.Reflection.Emit.Lightweight => 92
	i32 u0x0ec71be0, ; 64: lib_System.Security.SecureString.dll.so => 130
	i32 u0x0ecfdca9, ; 65: lib_Xamarin.Android.Glide.dll.so => 198
	i32 u0x0f99119d, ; 66: Xamarin.AndroidX.ConstraintLayout.dll => 217
	i32 u0x107abf20, ; 67: System.Threading.Timer.dll => 148
	i32 u0x109c6ab8, ; 68: Xamarin.AndroidX.Lifecycle.LiveData.dll => 236
	i32 u0x10b7d2b7, ; 69: Xamarin.AndroidX.Interpolator => 233
	i32 u0x10bf9929, ; 70: cs/Microsoft.Maui.Controls.resources.dll => 293
	i32 u0x10c1d9f6, ; 71: lib_System.Data.DataSetExtensions.dll.so => 23
	i32 u0x113d3381, ; 72: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 316
	i32 u0x1159791e, ; 73: System.IO.Pipes.AccessControl.dll => 55
	i32 u0x11d123fd, ; 74: System.Net.Ping.dll => 70
	i32 u0x13031348, ; 75: Xamarin.AndroidX.Activity.dll => 202
	i32 u0x132b30dd, ; 76: System.Numerics => 84
	i32 u0x1331a702, ; 77: lib_Xamarin.Google.Crypto.Tink.Android.dll.so => 273
	i32 u0x136bf828, ; 78: lib_System.Runtime.dll.so => 117
	i32 u0x14095832, ; 79: ja/Microsoft.Maui.Controls.resources.dll => 306
	i32 u0x146817a2, ; 80: Xamarin.AndroidX.Lifecycle.Common => 234
	i32 u0x14eaf2a7, ; 81: lib_System.ComponentModel.Annotations.dll.so => 13
	i32 u0x153e1455, ; 82: it/Microsoft.Maui.Controls.resources.dll => 305
	i32 u0x15502fa0, ; 83: cs/Microsoft.Maui.Controls.resources => 293
	i32 u0x15766b7b, ; 84: System.ServiceModel.Web => 132
	i32 u0x15c177ae, ; 85: lib_Microsoft.Extensions.Configuration.dll.so => 178
	i32 u0x15e184df, ; 86: lib_System.Runtime.Loader.dll.so => 110
	i32 u0x15ebe147, ; 87: System.IO.Pipes => 56
	i32 u0x16101ba2, ; 88: lib_Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll.so => 326
	i32 u0x1658bf94, ; 89: System.Transactions.Local => 150
	i32 u0x16646418, ; 90: System.Net.ServicePoint.dll => 75
	i32 u0x16a510e1, ; 91: System.Threading.Thread.dll => 146
	i32 u0x16fe439a, ; 92: System.Memory.dll => 63
	i32 u0x1766c1f7, ; 93: System.Threading.ThreadPool.dll => 147
	i32 u0x1778984a, ; 94: lib_Xamarin.AndroidX.ResourceInspection.Annotation.dll.so => 255
	i32 u0x17969339, ; 95: _Microsoft.Android.Resource.Designer => 329
	i32 u0x180c08d0, ; 96: WindowsBase => 166
	i32 u0x195d1904, ; 97: Xamarin.AndroidX.Lifecycle.Runtime.Android => 241
	i32 u0x198cd3eb, ; 98: lib_System.Security.Cryptography.Encoding.dll.so => 123
	i32 u0x19f6996b, ; 99: sv/Microsoft.Maui.Controls.resources.dll => 317
	i32 u0x1a4e3ec4, ; 100: Xamarin.AndroidX.ConstraintLayout.Core => 218
	i32 u0x1a61054f, ; 101: System.Collections => 12
	i32 u0x1ae0ec2c, ; 102: Xamarin.AndroidX.Fragment.dll => 231
	i32 u0x1ae969b2, ; 103: System.Security.Cryptography.X509Certificates => 126
	i32 u0x1b317bfd, ; 104: System.Web.HttpUtility.dll => 153
	i32 u0x1b46a9fd, ; 105: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll.so => 242
	i32 u0x1b5932ea, ; 106: lib_Mono.Android.Runtime.dll.so => 171
	i32 u0x1b611806, ; 107: System.Runtime.Serialization.Primitives.dll => 114
	i32 u0x1bc4415d, ; 108: mscorlib => 167
	i32 u0x1bc6ffe7, ; 109: lib_Java.Interop.dll.so => 169
	i32 u0x1bff388e, ; 110: System.dll => 165
	i32 u0x1c690cb9, ; 111: Xamarin.AndroidX.Interpolator.dll => 233
	i32 u0x1c78d08a, ; 112: lib_System.Private.Uri.dll.so => 87
	i32 u0x1d48410e, ; 113: lib_Xamarin.AndroidX.SlidingPaneLayout.dll.so => 259
	i32 u0x1d4d8185, ; 114: lib_System.Runtime.Serialization.dll.so => 116
	i32 u0x1dbae811, ; 115: System.ObjectModel => 85
	i32 u0x1dd2dc50, ; 116: id/Microsoft.Maui.Controls.resources.dll => 304
	i32 u0x1e092f31, ; 117: fi/Microsoft.Maui.Controls.resources.dll => 298
	i32 u0x1e9789de, ; 118: Microsoft.Extensions.Primitives.dll => 186
	i32 u0x1f1dceb7, ; 119: lib_System.Security.Cryptography.Primitives.dll.so => 125
	i32 u0x1f443e2d, ; 120: lib_System.AppContext.dll.so => 6
	i32 u0x1f6088c2, ; 121: System.Transactions.dll => 151
	i32 u0x1f6bf43d, ; 122: hi/Microsoft.Maui.Controls.resources => 301
	i32 u0x1f9b4faa, ; 123: System.Linq.Queryable => 61
	i32 u0x20216150, ; 124: Microsoft.Extensions.Logging => 182
	i32 u0x20303736, ; 125: System.IO.FileSystem.dll => 51
	i32 u0x2080b118, ; 126: System.Runtime.Extensions => 104
	i32 u0x20924146, ; 127: System.Runtime.Serialization.Xml => 115
	i32 u0x20bbb280, ; 128: System.Globalization.Calendars => 40
	i32 u0x2116ab2f, ; 129: Xamarin.JSpecify.dll => 282
	i32 u0x213954e7, ; 130: Jsr305Binding => 272
	i32 u0x218bdf07, ; 131: Xamarin.AndroidX.Core.ViewTree.dll => 222
	i32 u0x21f36ef8, ; 132: Xamarin.AndroidX.Window.Extensions.Core.Core => 270
	i32 u0x22697083, ; 133: System.Security.Cryptography.Cng => 121
	i32 u0x234b6fb2, ; 134: pt-BR/Microsoft.Maui.Controls.resources.dll => 312
	i32 u0x236793de, ; 135: lib_GoogleGson.dll.so => 177
	i32 u0x2386616a, ; 136: lib_System.ServiceModel.Web.dll.so => 132
	i32 u0x2397454a, ; 137: lib_System.Collections.Specialized.dll.so => 11
	i32 u0x239cf51b, ; 138: CommunityToolkit.Maui => 175
	i32 u0x23d83352, ; 139: System.IO.IsolatedStorage.dll => 52
	i32 u0x23eaab34, ; 140: lib_System.Core.dll.so => 21
	i32 u0x24154ecb, ; 141: System.IO.Compression.FileSystem => 44
	i32 u0x2459aaf0, ; 142: lib_System.Net.Sockets.dll.so => 76
	i32 u0x2493d7b9, ; 143: System.Security.Cryptography.Algorithms => 120
	i32 u0x24f53b2c, ; 144: lib_Mopups.dll.so => 194
	i32 u0x2512d1c5, ; 145: Xamarin.AndroidX.Lifecycle.Runtime.Android.dll => 241
	i32 u0x2568904f, ; 146: Xamarin.AndroidX.CustomView => 224
	i32 u0x26233b86, ; 147: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 229
	i32 u0x26249f17, ; 148: lib_Xamarin.AndroidX.CustomView.PoolingContainer.dll.so => 225
	i32 u0x262968a7, ; 149: lib_System.Reflection.Extensions.dll.so => 94
	i32 u0x262d781c, ; 150: lib-de-Microsoft.Maui.Controls.resources.dll.so => 295
	i32 u0x2645b6c3, ; 151: lib_CommunityToolkit.Maui.Core.dll.so => 176
	i32 u0x2660a755, ; 152: System.Net => 82
	i32 u0x271c8cd5, ; 153: lib_Microsoft.Maui.Maps.dll.so => 193
	i32 u0x27787397, ; 154: System.Text.Encodings.Web.dll => 137
	i32 u0x278c7790, ; 155: Xamarin.AndroidX.VersionedParcelable => 266
	i32 u0x27b53050, ; 156: lib_System.Data.Common.dll.so => 22
	i32 u0x27b6d01f, ; 157: Xamarin.AndroidX.Arch.Core.Common.dll => 209
	i32 u0x2814a96c, ; 158: System.Collections.Concurrent => 8
	i32 u0x282acf5e, ; 159: lib_System.IO.FileSystem.dll.so => 51
	i32 u0x28607aa1, ; 160: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 312
	i32 u0x287c1a88, ; 161: Xamarin.KotlinX.AtomicFU => 284
	i32 u0x28bdabca, ; 162: System.Net.Security => 74
	i32 u0x2904cf94, ; 163: ca/Microsoft.Maui.Controls.resources.dll => 292
	i32 u0x29293ff5, ; 164: System.Xml.Linq.dll => 156
	i32 u0x29352520, ; 165: Xamarin.KotlinX.Coroutines.Android.dll => 286
	i32 u0x29423679, ; 166: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 223
	i32 u0x295a9e3d, ; 167: System.Windows => 155
	i32 u0x296c7566, ; 168: lib_System.Xml.dll.so => 164
	i32 u0x29af2b3b, ; 169: System.Reflection.Emit => 93
	i32 u0x29bd7e5b, ; 170: Xamarin.Jetbrains.Annotations => 281
	i32 u0x29be9df3, ; 171: System.IO.Compression.ZipFile => 45
	i32 u0x2a1e8ecb, ; 172: ko/Microsoft.Maui.Controls.resources.dll => 307
	i32 u0x2a4afd4a, ; 173: de/Microsoft.Maui.Controls.resources.dll => 295
	i32 u0x2aaa494f, ; 174: Xamarin.Google.ErrorProne.TypeAnnotations => 275
	i32 u0x2b07b160, ; 175: lib_Xamarin.GooglePlayServices.Maps.dll.so => 279
	i32 u0x2b15ed29, ; 176: System.Runtime.Loader.dll => 110
	i32 u0x2ba1ca8c, ; 177: lib_System.Security.dll.so => 131
	i32 u0x2bd14e96, ; 178: System.Security.SecureString.dll => 130
	i32 u0x2cd6293c, ; 179: System.Diagnostics.Contracts.dll => 25
	i32 u0x2d052d0c, ; 180: Xamarin.Android.Glide.Annotations.dll => 199
	i32 u0x2d322560, ; 181: lib_System.Xml.XmlDocument.dll.so => 162
	i32 u0x2d445acd, ; 182: System.Net.Requests => 73
	i32 u0x2d745423, ; 183: System.IO.Pipes.dll => 56
	i32 u0x2e394f87, ; 184: System.IO.Compression => 46
	i32 u0x2eec5558, ; 185: lib_System.Reflection.dll.so => 98
	i32 u0x2f0980eb, ; 186: Microsoft.Extensions.Options => 185
	i32 u0x2f0fe5eb, ; 187: lib_System.Reflection.DispatchProxy.dll.so => 90
	i32 u0x2f1c1e69, ; 188: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 225
	i32 u0x2ff6fb9f, ; 189: System.Data.Common => 22
	i32 u0x302809e9, ; 190: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 238
	i32 u0x30a0e95c, ; 191: lib_System.Threading.Thread.dll.so => 146
	i32 u0x311247b5, ; 192: System.Private.Uri.dll => 87
	i32 u0x3142c245, ; 193: StreetLightApp.dll => 0
	i32 u0x317d5b75, ; 194: System.IO.Compression.Brotli => 43
	i32 u0x31a103c6, ; 195: System.Xml.XPath.dll => 161
	i32 u0x31b69d60, ; 196: System.Net.Quic => 72
	i32 u0x3312831d, ; 197: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 226
	i32 u0x33e88be1, ; 198: ar/Microsoft.Maui.Controls.resources => 291
	i32 u0x340ac0b8, ; 199: Microsoft.VisualBasic => 3
	i32 u0x34505120, ; 200: System.Globalization.dll => 42
	i32 u0x3463c971, ; 201: System.Net.Http.Json => 64
	i32 u0x34a66c56, ; 202: lib_System.IO.Pipes.dll.so => 56
	i32 u0x352e5794, ; 203: lib_Xamarin.Google.ErrorProne.Annotations.dll.so => 274
	i32 u0x35e25008, ; 204: System.ComponentModel.Primitives.dll => 16
	i32 u0x3612ff2c, ; 205: lib_System.IO.dll.so => 58
	i32 u0x362c87fc, ; 206: Microsoft.Maui.Maps => 193
	i32 u0x3635f196, ; 207: lib_Xamarin.GooglePlayServices.Basement.dll.so => 278
	i32 u0x364e69a3, ; 208: System.IO.MemoryMappedFiles.dll => 53
	i32 u0x36e9595b, ; 209: lib_System.Transactions.dll.so => 151
	i32 u0x370eff4f, ; 210: lib_System.Globalization.Extensions.dll.so => 41
	i32 u0x373f6a31, ; 211: tr/Microsoft.Maui.Controls.resources.dll => 319
	i32 u0x3751ef41, ; 212: Xamarin.Google.Guava.ListenableFuture => 276
	i32 u0x3787b992, ; 213: lib_System.ComponentModel.DataAnnotations.dll.so => 14
	i32 u0x37ea9cd7, ; 214: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 245
	i32 u0x382704bd, ; 215: lib_Xamarin.AndroidX.Emoji2.ViewsHelper.dll.so => 229
	i32 u0x38c136f7, ; 216: System.Runtime.InteropServices.JavaScript.dll => 106
	i32 u0x38d89c1d, ; 217: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 235
	i32 u0x38f24a24, ; 218: Newtonsoft.Json => 195
	i32 u0x39481653, ; 219: lib_mscorlib.dll.so => 167
	i32 u0x399f1f06, ; 220: Xamarin.Google.Crypto.Tink.Android => 273
	i32 u0x39adca5e, ; 221: Xamarin.AndroidX.Lifecycle.Common.dll => 234
	i32 u0x3a20ecf3, ; 222: System.Diagnostics.Tracing => 34
	i32 u0x3a2aaa1d, ; 223: System.Xml.XDocument => 159
	i32 u0x3a8b0a79, ; 224: lib_Xamarin.KotlinX.Coroutines.Android.dll.so => 286
	i32 u0x3acd0267, ; 225: System.Private.DataContractSerialization.dll => 86
	i32 u0x3ad7b407, ; 226: System.Diagnostics.Tools => 32
	i32 u0x3b008d80, ; 227: lib_Xamarin.AndroidX.DynamicAnimation.dll.so => 227
	i32 u0x3b2c715c, ; 228: System.Collections.dll => 12
	i32 u0x3b3271e4, ; 229: zh-Hans/Microsoft.Maui.Controls.resources => 323
	i32 u0x3b458447, ; 230: lib_System.Threading.Tasks.Dataflow.dll.so => 142
	i32 u0x3b45fb35, ; 231: System.IO.FileSystem => 51
	i32 u0x3b4797e5, ; 232: es/Microsoft.Maui.Controls.resources => 297
	i32 u0x3bb6bd33, ; 233: System.IO.UnmanagedMemoryStream.dll => 57
	i32 u0x3c5e5b62, ; 234: Xamarin.AndroidX.SavedState.dll => 256
	i32 u0x3cbffa41, ; 235: System.Drawing => 36
	i32 u0x3d548d92, ; 236: Microsoft.Extensions.DependencyInjection.Abstractions => 181
	i32 u0x3d5a6611, ; 237: da/Microsoft.Maui.Controls.resources.dll => 294
	i32 u0x3d7be038, ; 238: Xamarin.Google.ErrorProne.Annotations.dll => 274
	i32 u0x3dbaaf8f, ; 239: Xamarin.AndroidX.AppCompat => 207
	i32 u0x3dc84a49, ; 240: System.Drawing.Primitives.dll => 35
	i32 u0x3df150e9, ; 241: lib_Xamarin.AndroidX.Interpolator.dll.so => 233
	i32 u0x3e444eb4, ; 242: System.Linq.Expressions.dll => 59
	i32 u0x3e5c42fd, ; 243: lib_System.Reflection.TypeExtensions.dll.so => 97
	i32 u0x3eb776a1, ; 244: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 244
	i32 u0x3ebd41f6, ; 245: lib_System.Collections.dll.so => 12
	i32 u0x3ecd3024, ; 246: lib_System.Resources.Reader.dll.so => 99
	i32 u0x3eea4db8, ; 247: lib_Microsoft.Extensions.Primitives.dll.so => 186
	i32 u0x3f3e1e33, ; 248: lib_Xamarin.AndroidX.Lifecycle.Process.dll.so => 239
	i32 u0x3f9dcf8c, ; 249: GoogleGson => 177
	i32 u0x408b17f4, ; 250: System.ComponentModel.TypeConverter => 17
	i32 u0x409e66d8, ; 251: Xamarin.Kotlin.StdLib => 283
	i32 u0x41761b2c, ; 252: System => 165
	i32 u0x417c4c3b, ; 253: lib_AsyncAwaitBestPractices.dll.so => 174
	i32 u0x4232ae7b, ; 254: lib_System.Reflection.Emit.dll.so => 93
	i32 u0x42be2972, ; 255: lib_System.Text.Encodings.Web.dll.so => 137
	i32 u0x42c091c1, ; 256: lib_Xamarin.Android.Glide.GifDecoder.dll.so => 201
	i32 u0x42da3e50, ; 257: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 242
	i32 u0x43362f15, ; 258: Microsoft.Extensions.Logging.Debug => 184
	i32 u0x4393e151, ; 259: lib-th-Microsoft.Maui.Controls.resources.dll.so => 318
	i32 u0x441f18e1, ; 260: lib_System.Security.Cryptography.OpenSsl.dll.so => 124
	i32 u0x444e5c8e, ; 261: lib_System.ComponentModel.TypeConverter.dll.so => 17
	i32 u0x44549c93, ; 262: lib_System.Net.WebProxy.dll.so => 79
	i32 u0x4474042c, ; 263: lib_System.Numerics.Vectors.dll.so => 83
	i32 u0x447dc2e6, ; 264: Xamarin.AndroidX.Window => 269
	i32 u0x44845810, ; 265: lib_System.Net.Http.dll.so => 65
	i32 u0x44c3958b, ; 266: lib_System.Private.DataContractSerialization.dll.so => 86
	i32 u0x45bde382, ; 267: lib_System.Windows.dll.so => 155
	i32 u0x45c677b2, ; 268: System.Web.dll => 154
	i32 u0x460b48eb, ; 269: Xamarin.AndroidX.VectorDrawable.Animated => 265
	i32 u0x463a8801, ; 270: Xamarin.AndroidX.Navigation.Runtime.dll => 251
	i32 u0x464305ed, ; 271: fi/Microsoft.Maui.Controls.resources => 298
	i32 u0x466ae52b, ; 272: lib_System.Threading.Overlapped.dll.so => 141
	i32 u0x47a87de7, ; 273: lib_System.Resources.Writer.dll.so => 101
	i32 u0x47b79c15, ; 274: pl/Microsoft.Maui.Controls.resources.dll => 311
	i32 u0x47c7b4fa, ; 275: Xamarin.AndroidX.Arch.Core.Common => 209
	i32 u0x480a69ad, ; 276: System.Diagnostics.Process => 29
	i32 u0x48aa6be3, ; 277: System.IO.IsolatedStorage => 52
	i32 u0x48bf92c4, ; 278: lib_Xamarin.AndroidX.Collection.dll.so => 213
	i32 u0x49654709, ; 279: lib_System.Threading.Timer.dll.so => 148
	i32 u0x499b8219, ; 280: nb/Microsoft.Maui.Controls.resources.dll => 309
	i32 u0x4a0189ae, ; 281: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 301
	i32 u0x4a18f6f7, ; 282: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 270
	i32 u0x4a4cd262, ; 283: Xamarin.AndroidX.Collection.Jvm.dll => 214
	i32 u0x4a8cb221, ; 284: lib_Xamarin.JSpecify.dll.so => 282
	i32 u0x4aaf6f7c, ; 285: Microsoft.Win32.Registry => 5
	i32 u0x4ae97402, ; 286: lib_Microsoft.Maui.Graphics.dll.so => 192
	i32 u0x4b275854, ; 287: Xamarin.KotlinX.Serialization.Core.Jvm => 290
	i32 u0x4b5eebe5, ; 288: Xamarin.AndroidX.Startup.StartupRuntime.dll => 260
	i32 u0x4b64b158, ; 289: Xamarin.KotlinX.Coroutines.Core.dll => 287
	i32 u0x4b863c7a, ; 290: lib_System.Private.Xml.Linq.dll.so => 88
	i32 u0x4b8a64a7, ; 291: Xamarin.AndroidX.VectorDrawable => 264
	i32 u0x4bb12d98, ; 292: lib_System.Runtime.Serialization.Xml.dll.so => 115
	i32 u0x4be46b58, ; 293: Xamarin.AndroidX.Collection.Ktx => 215
	i32 u0x4c071bea, ; 294: Xamarin.KotlinX.Coroutines.Android => 286
	i32 u0x4c3393c5, ; 295: Xamarin.AndroidX.Annotation.Jvm => 206
	i32 u0x4d14ee2b, ; 296: Xamarin.AndroidX.DrawerLayout.dll => 226
	i32 u0x4de0ce3b, ; 297: lib_Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll.so => 253
	i32 u0x4e08a30b, ; 298: System.Private.DataContractSerialization => 86
	i32 u0x4e98c997, ; 299: lib_Xamarin.AndroidX.Window.Extensions.Core.Core.dll.so => 270
	i32 u0x4ed70c83, ; 300: Xamarin.AndroidX.Window.dll => 269
	i32 u0x4eed2679, ; 301: System.Linq => 62
	i32 u0x4f97822f, ; 302: System.Runtime.Serialization.Json.dll => 113
	i32 u0x50255dd9, ; 303: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 302
	i32 u0x50acdfd7, ; 304: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 292
	i32 u0x514d38cd, ; 305: System.IO => 58
	i32 u0x52114ed3, ; 306: Xamarin.AndroidX.SavedState => 256
	i32 u0x523dc4c1, ; 307: System.Resources.ResourceManager => 100
	i32 u0x533678bd, ; 308: lib_System.Private.CoreLib.dll.so => 173
	i32 u0x53701274, ; 309: lib_System.IO.FileSystem.Watcher.dll.so => 50
	i32 u0x53936ab4, ; 310: System.Configuration.dll => 19
	i32 u0x53cefc50, ; 311: Xamarin.AndroidX.CoordinatorLayout => 219
	i32 u0x53f80ba6, ; 312: System.Runtime.Serialization.Formatters.dll => 112
	i32 u0x5423e47b, ; 313: System.Runtime.CompilerServices.Unsafe => 102
	i32 u0x54246761, ; 314: lib_System.Diagnostics.Tools.dll.so => 32
	i32 u0x5498bac9, ; 315: lib_Microsoft.VisualBasic.dll.so => 3
	i32 u0x54ca50cb, ; 316: System.Runtime.CompilerServices.VisualC => 103
	i32 u0x557217fe, ; 317: lib_System.Numerics.dll.so => 84
	i32 u0x557b5293, ; 318: System.Runtime.Handles => 105
	i32 u0x558bc221, ; 319: Xamarin.Google.Crypto.Tink.Android.dll => 273
	i32 u0x55ab7451, ; 320: Xamarin.AndroidX.Lifecycle.Common.Jvm => 235
	i32 u0x55b0fe2e, ; 321: lib_WatsonWebsocket.dll.so => 197
	i32 u0x55d10363, ; 322: System.Net.Quic.dll => 72
	i32 u0x55dfaca3, ; 323: lib_Microsoft.Win32.Primitives.dll.so => 4
	i32 u0x55e55df2, ; 324: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 245
	i32 u0x568cd628, ; 325: System.Formats.Asn1.dll => 38
	i32 u0x569fcb36, ; 326: System.Diagnostics.Tools.dll => 32
	i32 u0x56c018af, ; 327: lib_System.IO.UnmanagedMemoryStream.dll.so => 57
	i32 u0x56e36530, ; 328: System.Runtime.Extensions.dll => 104
	i32 u0x56e7a7ad, ; 329: System.Net.Security.dll => 74
	i32 u0x5718a9ef, ; 330: System.Collections.Immutable.dll => 9
	i32 u0x57201017, ; 331: System.Security.Cryptography.OpenSsl => 124
	i32 u0x57261233, ; 332: System.IO.Compression.dll => 46
	i32 u0x57924923, ; 333: Xamarin.AndroidX.AppCompat.AppCompatResources => 208
	i32 u0x57a5e912, ; 334: Microsoft.Extensions.Primitives => 186
	i32 u0x5833866d, ; 335: System.Collections.Immutable => 9
	i32 u0x583e844f, ; 336: System.IO.Compression.Brotli.dll => 43
	i32 u0x58a57897, ; 337: Microsoft.Win32.Primitives => 4
	i32 u0x58cffa99, ; 338: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 257
	i32 u0x58fd6613, ; 339: hi/Microsoft.Maui.Controls.resources.dll => 301
	i32 u0x596b5b3a, ; 340: lib_System.Drawing.Primitives.dll.so => 35
	i32 u0x5a48cf6c, ; 341: el/Microsoft.Maui.Controls.resources.dll => 296
	i32 u0x5b9331b6, ; 342: System.Diagnostics.TextWriterTraceListener => 31
	i32 u0x5be451c7, ; 343: lib_Xamarin.AndroidX.Browser.dll.so => 211
	i32 u0x5bf8ca0f, ; 344: System.Text.RegularExpressions.dll => 139
	i32 u0x5bfdbb43, ; 345: System.Reflection.Emit.dll => 93
	i32 u0x5c680b40, ; 346: System.Reflection.Extensions.dll => 94
	i32 u0x5c7be408, ; 347: sk/Microsoft.Maui.Controls.resources.dll => 316
	i32 u0x5cabc9a4, ; 348: fr/Microsoft.Maui.Controls.resources => 299
	i32 u0x5d552ab7, ; 349: System.IO.FileSystem.Primitives => 49
	i32 u0x5d5a6c40, ; 350: System.Threading.Tasks.Dataflow.dll => 142
	i32 u0x5dccd455, ; 351: System.Runtime.Serialization.Json => 113
	i32 u0x5e0b6fdc, ; 352: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 290
	i32 u0x5e2d7514, ; 353: System.Threading.Overlapped => 141
	i32 u0x5e2e3abe, ; 354: lib_Microsoft.VisualBasic.Core.dll.so => 2
	i32 u0x5e33306d, ; 355: sv/Microsoft.Maui.Controls.resources => 317
	i32 u0x5e7321d2, ; 356: lib_System.ComponentModel.Primitives.dll.so => 16
	i32 u0x5ed5f779, ; 357: zh-Hant/Microsoft.Maui.Controls.resources => 324
	i32 u0x5ef2ee25, ; 358: System.Runtime.Serialization.dll => 116
	i32 u0x5f3ec4dd, ; 359: Xamarin.Google.ErrorProne.Annotations => 274
	i32 u0x5f6f0b5b, ; 360: System.Xml.Serialization => 158
	i32 u0x5f93db6e, ; 361: Microsoft.Maui.Controls.HotReload.Forms.dll => 325
	i32 u0x5fa7b851, ; 362: System.Net.WebClient => 77
	i32 u0x6078995d, ; 363: System.Net.WebSockets.Client.dll => 80
	i32 u0x60892624, ; 364: lib_System.Formats.Tar.dll.so => 39
	i32 u0x60b0136a, ; 365: Xamarin.AndroidX.Loader.dll => 248
	i32 u0x60b33958, ; 366: System.Dynamic.Runtime => 37
	i32 u0x60d97228, ; 367: Xamarin.AndroidX.ViewPager2 => 268
	i32 u0x60ec189c, ; 368: lib_Xamarin.AndroidX.Arch.Core.Runtime.dll.so => 210
	i32 u0x616edae3, ; 369: CommunityToolkit.Maui.Core.dll => 176
	i32 u0x6176eff7, ; 370: Xamarin.AndroidX.Emoji2.ViewsHelper => 229
	i32 u0x6188ba7e, ; 371: Xamarin.AndroidX.CursorAdapter => 223
	i32 u0x61b9038d, ; 372: System.Net.Http.dll => 65
	i32 u0x61c036ca, ; 373: System.Text.RegularExpressions => 139
	i32 u0x61d59e0e, ; 374: System.ComponentModel.EventBasedAsync.dll => 15
	i32 u0x62021776, ; 375: lib_System.IO.Compression.dll.so => 46
	i32 u0x620a8774, ; 376: lib_System.Xml.ReaderWriter.dll.so => 157
	i32 u0x625755ef, ; 377: lib_WindowsBase.dll.so => 166
	i32 u0x62c6282e, ; 378: System.Runtime => 117
	i32 u0x62cec1a2, ; 379: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 288
	i32 u0x62d6c1e4, ; 380: Xamarin.AndroidX.Tracing.Tracing.dll => 262
	i32 u0x62d6ea10, ; 381: Xamarin.Google.Android.Material.dll => 271
	i32 u0x63635343, ; 382: Mopups.dll => 194
	i32 u0x638b1991, ; 383: Xamarin.AndroidX.ConstraintLayout => 217
	i32 u0x63dee9da, ; 384: System.IO.FileSystem.DriveInfo.dll => 48
	i32 u0x63fca3d0, ; 385: System.Net.Primitives.dll => 71
	i32 u0x640c0103, ; 386: System.Net.WebSockets => 81
	i32 u0x641979dd, ; 387: Xamarin.JSpecify => 282
	i32 u0x641f3e5a, ; 388: System.Security.Cryptography => 127
	i32 u0x64d1e4f5, ; 389: System.Reflection.Metadata => 95
	i32 u0x6525abc9, ; 390: System.Security.Cryptography.Csp => 122
	i32 u0x654b1498, ; 391: lib_System.Transactions.Local.dll.so => 150
	i32 u0x656b7698, ; 392: System.Diagnostics.Debug.dll => 26
	i32 u0x6670b12e, ; 393: lib_System.Security.AccessControl.dll.so => 118
	i32 u0x66888819, ; 394: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 238
	i32 u0x66e27484, ; 395: System.Reflection.dll => 98
	i32 u0x66ffb0f8, ; 396: System.Diagnostics.FileVersionInfo.dll => 28
	i32 u0x6715dc86, ; 397: Xamarin.AndroidX.CardView.dll => 212
	i32 u0x67577fe1, ; 398: lib_System.Runtime.CompilerServices.VisualC.dll.so => 103
	i32 u0x677cd287, ; 399: ro/Microsoft.Maui.Controls.resources.dll => 314
	i32 u0x67965db9, ; 400: lib_Microsoft.Maui.Controls.Maps.dll.so => 188
	i32 u0x67fe8db2, ; 401: System.Transactions.Local.dll => 150
	i32 u0x68139a0d, ; 402: System.IO.Pipelines.dll => 54
	i32 u0x6816ab6a, ; 403: Mono.Android.Export => 170
	i32 u0x6853a83d, ; 404: Microsoft.Win32.Primitives.dll => 4
	i32 u0x68cc9d1e, ; 405: System.Resources.Reader.dll => 99
	i32 u0x68f61ae4, ; 406: lib_System.Formats.Asn1.dll.so => 38
	i32 u0x690d4b7d, ; 407: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 324
	i32 u0x69239124, ; 408: System.Diagnostics.TraceSource.dll => 33
	i32 u0x693efa35, ; 409: lib_System.Net.WebHeaderCollection.dll.so => 78
	i32 u0x6942234e, ; 410: System.Reflection.Extensions => 94
	i32 u0x6947f945, ; 411: Xamarin.AndroidX.SwipeRefreshLayout => 261
	i32 u0x6988f147, ; 412: Microsoft.Extensions.Logging.dll => 182
	i32 u0x69ae5451, ; 413: lib_System.Runtime.InteropServices.JavaScript.dll.so => 106
	i32 u0x69dc03cc, ; 414: System.Core.dll => 21
	i32 u0x69ec0683, ; 415: System.Globalization.Extensions.dll => 41
	i32 u0x69f4f41d, ; 416: lib_Xamarin.AndroidX.AppCompat.dll.so => 207
	i32 u0x6a216153, ; 417: Mono.Android.Runtime.dll => 171
	i32 u0x6a539b49, ; 418: lib_System.Runtime.Extensions.dll.so => 104
	i32 u0x6a96652d, ; 419: Xamarin.AndroidX.Fragment => 231
	i32 u0x6afaf338, ; 420: lib_System.Threading.dll.so => 149
	i32 u0x6b645ada, ; 421: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 299
	i32 u0x6bcd3296, ; 422: Xamarin.AndroidX.Loader => 248
	i32 u0x6be1e423, ; 423: nb/Microsoft.Maui.Controls.resources => 309
	i32 u0x6be29904, ; 424: lib_Xamarin.GooglePlayServices.Base.dll.so => 277
	i32 u0x6c111525, ; 425: Xamarin.Kotlin.StdLib.dll => 283
	i32 u0x6c13413e, ; 426: Xamarin.Google.Android.Material => 271
	i32 u0x6c5562e0, ; 427: lib_Xamarin.KotlinX.Coroutines.Core.dll.so => 287
	i32 u0x6c652ce8, ; 428: Xamarin.AndroidX.Navigation.UI.dll => 252
	i32 u0x6c687fa7, ; 429: Microsoft.VisualBasic.Core => 2
	i32 u0x6c96614d, ; 430: hu/Microsoft.Maui.Controls.resources => 303
	i32 u0x6cbab720, ; 431: System.Text.Encoding.Extensions => 135
	i32 u0x6cc30c8c, ; 432: System.Runtime.Serialization.Formatters => 112
	i32 u0x6cea70ab, ; 433: Microsoft.VisualStudio.DesignTools.TapContract => 327
	i32 u0x6cf3d432, ; 434: lib_Xamarin.AndroidX.VersionedParcelable.dll.so => 266
	i32 u0x6cff90ba, ; 435: Microsoft.Extensions.Logging.Abstractions.dll => 183
	i32 u0x6dcaebf7, ; 436: uk/Microsoft.Maui.Controls.resources.dll => 320
	i32 u0x6e1ed932, ; 437: Xamarin.Android.Glide.Annotations => 199
	i32 u0x6ec71a65, ; 438: System.Linq.Expressions => 59
	i32 u0x6f7a29e4, ; 439: System.Reflection.Primitives => 96
	i32 u0x6fab02f2, ; 440: lib_Xamarin.AndroidX.ConstraintLayout.dll.so => 217
	i32 u0x7009e4c3, ; 441: System.Formats.Tar.dll => 39
	i32 u0x705fa726, ; 442: Xamarin.AndroidX.Arch.Core.Runtime.dll => 210
	i32 u0x7068d361, ; 443: Microsoft.VisualStudio.DesignTools.TapContract.dll => 327
	i32 u0x7070c6c0, ; 444: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 323
	i32 u0x70972b6d, ; 445: System.Diagnostics.Contracts => 25
	i32 u0x70a66bdd, ; 446: System.Reflection.Metadata.dll => 95
	i32 u0x7124cf39, ; 447: System.Reflection.DispatchProxy => 90
	i32 u0x71490522, ; 448: System.Resources.ResourceManager.dll => 100
	i32 u0x71c62d98, ; 449: Xamarin.GooglePlayServices.Basement => 278
	i32 u0x71dc7c8b, ; 450: System.Collections.NonGeneric.dll => 10
	i32 u0x72fcebde, ; 451: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 208
	i32 u0x731dd955, ; 452: lib_Mono.Android.dll.so => 172
	i32 u0x739bd4a8, ; 453: System.Private.Xml.Linq => 88
	i32 u0x73b20433, ; 454: lib_System.IO.FileSystem.Primitives.dll.so => 49
	i32 u0x73fbecbe, ; 455: lib_System.Memory.dll.so => 63
	i32 u0x74126030, ; 456: lib_System.Net.WebClient.dll.so => 77
	i32 u0x74a1c5bb, ; 457: System.Resources.Writer => 101
	i32 u0x74d743bf, ; 458: ja/Microsoft.Maui.Controls.resources => 306
	i32 u0x74eee4ef, ; 459: Xamarin.AndroidX.Security.SecurityCrypto.dll => 258
	i32 u0x75533a5e, ; 460: Microsoft.Extensions.Configuration.dll => 178
	i32 u0x7554eac3, ; 461: AsyncAwaitBestPractices => 174
	i32 u0x7593c33f, ; 462: lib_System.IO.FileSystem.AccessControl.dll.so => 47
	i32 u0x765c50a4, ; 463: Xamarin.Android.Glide.GifDecoder => 201
	i32 u0x77ec19b4, ; 464: System.Buffers.dll => 7
	i32 u0x781074ce, ; 465: hr/Microsoft.Maui.Controls.resources => 302
	i32 u0x784d3e49, ; 466: lib_System.Net.dll.so => 82
	i32 u0x785e97f1, ; 467: Xamarin.AndroidX.Lifecycle.ViewModel => 244
	i32 u0x78b622b1, ; 468: ar/Microsoft.Maui.Controls.resources.dll => 291
	i32 u0x790376c9, ; 469: lib_Xamarin.AndroidX.Annotation.Experimental.dll.so => 205
	i32 u0x791a414b, ; 470: Xamarin.Android.Glide => 198
	i32 u0x7970be4f, ; 471: lib-he-Microsoft.Maui.Controls.resources.dll.so => 300
	i32 u0x79d00016, ; 472: it/Microsoft.Maui.Controls.resources => 305
	i32 u0x79eb68ee, ; 473: System.Private.Xml => 89
	i32 u0x7a80bd4e, ; 474: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 237
	i32 u0x7aca0819, ; 475: System.Windows.dll => 155
	i32 u0x7b350579, ; 476: lib__Microsoft.Android.Resource.Designer.dll.so => 329
	i32 u0x7b473a37, ; 477: lib_Xamarin.AndroidX.Fragment.Ktx.dll.so => 232
	i32 u0x7b6f419e, ; 478: System.Diagnostics.TraceSource => 33
	i32 u0x7b8f6ff7, ; 479: lib_System.Runtime.Serialization.Json.dll.so => 113
	i32 u0x7bf8cdab, ; 480: System.Runtime.dll => 117
	i32 u0x7c51ebd4, ; 481: lib_System.Net.HttpListener.dll.so => 66
	i32 u0x7c9bf920, ; 482: System.Numerics.Vectors => 83
	i32 u0x7d065c82, ; 483: lib_Xamarin.Google.ErrorProne.TypeAnnotations.dll.so => 275
	i32 u0x7d702d52, ; 484: lib_System.Text.Encoding.dll.so => 136
	i32 u0x7e3cc7a5, ; 485: Microsoft.VisualStudio.DesignTools.XamlTapContract.dll => 328
	i32 u0x7ec9ffe9, ; 486: System.Console => 20
	i32 u0x7eed5835, ; 487: Xamarin.GooglePlayServices.Base.dll => 277
	i32 u0x7fb38cd2, ; 488: System.Collections.Specialized => 11
	i32 u0x7fc7a41e, ; 489: System.Xml.XmlSerializer.dll => 163
	i32 u0x7fd90a71, ; 490: lib_System.Text.Encoding.CodePages.dll.so => 134
	i32 u0x7fdcdc37, ; 491: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 307
	i32 u0x7ff65cf5, ; 492: Microsoft.VisualBasic.dll => 3
	i32 u0x802a7166, ; 493: lib_System.Diagnostics.FileVersionInfo.dll.so => 28
	i32 u0x8030853e, ; 494: ko/Microsoft.Maui.Controls.resources => 307
	i32 u0x8044e1bd, ; 495: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 308
	i32 u0x8081c489, ; 496: lib_Jsr305Binding.dll.so => 272
	i32 u0x80bd55ad, ; 497: Microsoft.Maui => 190
	i32 u0x80f2f56e, ; 498: lib_System.Runtime.Serialization.Formatters.dll.so => 112
	i32 u0x810c11c2, ; 499: ro/Microsoft.Maui.Controls.resources => 314
	i32 u0x8115bdf3, ; 500: lib_System.Resources.ResourceManager.dll.so => 100
	i32 u0x816751d8, ; 501: lib_System.Diagnostics.DiagnosticSource.dll.so => 27
	i32 u0x81a110ae, ; 502: lib_System.ComponentModel.EventBasedAsync.dll.so => 15
	i32 u0x820d22b3, ; 503: Microsoft.Extensions.Options.dll => 185
	i32 u0x82364da2, ; 504: lib_System.Buffers.dll.so => 7
	i32 u0x82a8237c, ; 505: Microsoft.Extensions.Logging.Abstractions => 183
	i32 u0x82b6c85e, ; 506: System.ObjectModel.dll => 85
	i32 u0x82bb5429, ; 507: lib_System.Linq.Expressions.dll.so => 59
	i32 u0x82c1cf3e, ; 508: lib_System.Net.Quic.dll.so => 72
	i32 u0x832ec206, ; 509: lib_System.Diagnostics.StackTrace.dll.so => 30
	i32 u0x83323b38, ; 510: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 288
	i32 u0x8334206b, ; 511: System.Net.Http => 65
	i32 u0x842e93b2, ; 512: Xamarin.AndroidX.VectorDrawable.Animated.dll => 265
	i32 u0x8471e4ec, ; 513: System.Threading.Tasks.Parallel => 144
	i32 u0x857e4dd2, ; 514: lib_System.Net.WebSockets.dll.so => 81
	i32 u0x8628f1a4, ; 515: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 315
	i32 u0x863c6ac5, ; 516: System.Xml.Serialization.dll => 158
	i32 u0x867c9c52, ; 517: System.Globalization.Extensions => 41
	i32 u0x86b0fd78, ; 518: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll.so => 246
	i32 u0x86bba59b, ; 519: lib_Microsoft.Maui.Controls.dll.so => 187
	i32 u0x8702d9a2, ; 520: System.Security.AccessControl.dll => 118
	i32 u0x871c9c1b, ; 521: Microsoft.Extensions.Configuration.Abstractions => 179
	i32 u0x872eeb7b, ; 522: Xamarin.Android.Glide.DiskLruCache.dll => 200
	i32 u0x875633cc, ; 523: fr/Microsoft.Maui.Controls.resources.dll => 299
	i32 u0x87a1a22b, ; 524: lib-it-Microsoft.Maui.Controls.resources.dll.so => 305
	i32 u0x87e25095, ; 525: Xamarin.AndroidX.RecyclerView.dll => 254
	i32 u0x87e7fdbb, ; 526: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 310
	i32 u0x881f94da, ; 527: lib_netstandard.dll.so => 168
	i32 u0x8873eb17, ; 528: th/Microsoft.Maui.Controls.resources => 318
	i32 u0x887ae6a1, ; 529: lib_Xamarin.AndroidX.Lifecycle.Runtime.Android.dll.so => 241
	i32 u0x88acefcd, ; 530: System.ServiceModel.Web.dll => 132
	i32 u0x88d8bfaa, ; 531: System.Net.Sockets => 76
	i32 u0x88ffe49e, ; 532: System.Net.Mail => 67
	i32 u0x89461bcb, ; 533: Microsoft.Maui.Controls.Maps.dll => 188
	i32 u0x896b7878, ; 534: System.Private.CoreLib.dll => 173
	i32 u0x8a068af2, ; 535: Xamarin.AndroidX.Annotation.dll => 204
	i32 u0x8a52059a, ; 536: System.Threading.Tasks.Parallel.dll => 144
	i32 u0x8b804dbf, ; 537: System.Runtime.InteropServices.RuntimeInformation.dll => 107
	i32 u0x8bbaa2cd, ; 538: System.ValueTuple => 152
	i32 u0x8c20c628, ; 539: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 298
	i32 u0x8c20f140, ; 540: lib_System.Console.dll.so => 20
	i32 u0x8c40e0db, ; 541: System.Net.Primitives => 71
	i32 u0x8d19e4a2, ; 542: lib_Xamarin.AndroidX.Lifecycle.LiveData.dll.so => 236
	i32 u0x8d24e767, ; 543: System.Xml.ReaderWriter.dll => 157
	i32 u0x8d3fac99, ; 544: tr/Microsoft.Maui.Controls.resources => 319
	i32 u0x8d52b2e2, ; 545: Microsoft.Extensions.Configuration => 178
	i32 u0x8d52d3de, ; 546: lib_System.Threading.Tasks.dll.so => 145
	i32 u0x8dc6dbce, ; 547: System.Security.Cryptography.Csp.dll => 122
	i32 u0x8dcb0101, ; 548: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 250
	i32 u0x8e02310f, ; 549: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 291
	i32 u0x8e114655, ; 550: System.Security.Principal.Windows.dll => 128
	i32 u0x8f24faee, ; 551: System.Web.HttpUtility => 153
	i32 u0x8f41c524, ; 552: Xamarin.AndroidX.Emoji2.dll => 228
	i32 u0x8f4e087a, ; 553: lib_System.Web.dll.so => 154
	i32 u0x8f8c64e2, ; 554: lib_System.Private.Xml.dll.so => 89
	i32 u0x8fa56e96, ; 555: Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll => 326
	i32 u0x905355ed, ; 556: System.Threading.Tasks.Dataflow => 142
	i32 u0x905caa9d, ; 557: nl/Microsoft.Maui.Controls.resources => 310
	i32 u0x906d466b, ; 558: Xamarin.AndroidX.Collection.Ktx.dll => 215
	i32 u0x90e50509, ; 559: lib_System.Reflection.Primitives.dll.so => 96
	i32 u0x911615a7, ; 560: lib_Xamarin.AndroidX.Fragment.dll.so => 231
	i32 u0x912896e5, ; 561: System.Console.dll => 20
	i32 u0x9130f5e7, ; 562: System.ComponentModel.DataAnnotations.dll => 14
	i32 u0x91abdf3a, ; 563: lib_Xamarin.AndroidX.Startup.StartupRuntime.dll.so => 260
	i32 u0x924edee6, ; 564: System.Text.Encoding.dll => 136
	i32 u0x928c75ca, ; 565: System.Net.Sockets.dll => 76
	i32 u0x92916334, ; 566: System.Linq.Parallel.dll => 60
	i32 u0x92f50938, ; 567: Xamarin.AndroidX.ConstraintLayout.Core.dll => 218
	i32 u0x93554fdc, ; 568: netstandard.dll => 168
	i32 u0x93634cc0, ; 569: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll.so => 238
	i32 u0x93918882, ; 570: Java.Interop.dll => 169
	i32 u0x93dba8a1, ; 571: Microsoft.Maui.Controls => 187
	i32 u0x940d5c2f, ; 572: System.ComponentModel.EventBasedAsync => 15
	i32 u0x94147f61, ; 573: System.Net.ServicePoint => 75
	i32 u0x9438d78e, ; 574: lib_System.Text.Json.dll.so => 138
	i32 u0x9469ba86, ; 575: lib_Xamarin.AndroidX.Lifecycle.Runtime.dll.so => 240
	i32 u0x94798bc5, ; 576: System.AppContext.dll => 6
	i32 u0x94a1db18, ; 577: lib-id-Microsoft.Maui.Controls.resources.dll.so => 304
	i32 u0x94fad8e5, ; 578: lib_Xamarin.AndroidX.Activity.Ktx.dll.so => 203
	i32 u0x95178668, ; 579: System.Data.DataSetExtensions => 23
	i32 u0x955cf248, ; 580: Xamarin.AndroidX.Lifecycle.Runtime.dll => 240
	i32 u0x9593ae7f, ; 581: lib_Xamarin.AndroidX.SavedState.dll.so => 256
	i32 u0x963ac2da, ; 582: sk/Microsoft.Maui.Controls.resources => 316
	i32 u0x9659e17c, ; 583: Xamarin.Android.Glide.dll => 198
	i32 u0x96bea474, ; 584: lib_Microsoft.Maui.Controls.Xaml.dll.so => 189
	i32 u0x974b89a2, ; 585: System.Reflection.Emit.Lightweight.dll => 92
	i32 u0x98ba5a04, ; 586: Microsoft.CSharp => 1
	i32 u0x98e90c02, ; 587: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 280
	i32 u0x9930ee42, ; 588: System.Text.Encodings.Web => 137
	i32 u0x999dcf0d, ; 589: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android => 243
	i32 u0x99e2e424, ; 590: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 242
	i32 u0x99e370f2, ; 591: Xamarin.AndroidX.VectorDrawable.dll => 264
	i32 u0x9a1756ac, ; 592: System.Text.Encoding.Extensions.dll => 135
	i32 u0x9a20430d, ; 593: System.Net.Ping => 70
	i32 u0x9a5a3337, ; 594: System.Threading.ThreadPool => 147
	i32 u0x9b24ab96, ; 595: lib_System.Runtime.Serialization.Primitives.dll.so => 114
	i32 u0x9b500441, ; 596: Xamarin.KotlinX.Coroutines.Core.Jvm => 288
	i32 u0x9b5e5b1c, ; 597: lib_System.Diagnostics.Contracts.dll.so => 25
	i32 u0x9be14c08, ; 598: Xamarin.AndroidX.Fragment.Ktx => 232
	i32 u0x9bf052c1, ; 599: Microsoft.Extensions.Logging.Debug.dll => 184
	i32 u0x9bfe3a41, ; 600: System.Private.Xml.dll => 89
	i32 u0x9c165ff9, ; 601: System.Reflection.TypeExtensions.dll => 97
	i32 u0x9c375496, ; 602: Xamarin.AndroidX.CursorAdapter.dll => 223
	i32 u0x9c70e6c9, ; 603: Xamarin.AndroidX.DynamicAnimation => 227
	i32 u0x9c96ac4c, ; 604: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 252
	i32 u0x9c97ad4a, ; 605: System.Diagnostics.TextWriterTraceListener.dll => 31
	i32 u0x9cc03a58, ; 606: System.IO.Compression.ZipFile.dll => 45
	i32 u0x9cd341b2, ; 607: lib_System.Threading.Tasks.Parallel.dll.so => 144
	i32 u0x9cf12c56, ; 608: Xamarin.AndroidX.Lifecycle.LiveData => 236
	i32 u0x9e78dac1, ; 609: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 247
	i32 u0x9ec022c0, ; 610: Xamarin.Android.Glide.DiskLruCache => 200
	i32 u0x9ec4cf01, ; 611: System.Runtime.Loader => 110
	i32 u0x9ecf752a, ; 612: System.Xml.XDocument.dll => 159
	i32 u0x9ee22cc0, ; 613: System.Drawing.Primitives => 35
	i32 u0x9f3b757e, ; 614: Xamarin.KotlinX.Coroutines.Core => 287
	i32 u0x9f7ea921, ; 615: lib_System.Runtime.InteropServices.dll.so => 108
	i32 u0x9f8c6f40, ; 616: System.Data.Common.dll => 22
	i32 u0xa026a50c, ; 617: System.Runtime.Serialization.Xml.dll => 115
	i32 u0xa090e36a, ; 618: System.IO.dll => 58
	i32 u0xa0fb56af, ; 619: lib_System.Text.RegularExpressions.dll.so => 139
	i32 u0xa0ff7514, ; 620: Xamarin.AndroidX.Tracing.Tracing => 262
	i32 u0xa1d8b647, ; 621: System.Threading.Tasks.dll => 145
	i32 u0xa1fd7d9f, ; 622: System.Security.Claims => 119
	i32 u0xa21f5a1f, ; 623: System.Security.Cryptography.Cng.dll => 121
	i32 u0xa25c90e5, ; 624: lib_Xamarin.AndroidX.Core.dll.so => 220
	i32 u0xa262a30f, ; 625: System.Runtime.Numerics.dll => 111
	i32 u0xa2ce8457, ; 626: lib-es-Microsoft.Maui.Controls.resources.dll.so => 297
	i32 u0xa2e0939b, ; 627: Xamarin.AndroidX.Activity => 202
	i32 u0xa30769e5, ; 628: System.Threading.Channels => 140
	i32 u0xa32eb6f0, ; 629: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 208
	i32 u0xa35f8f92, ; 630: System.IO.Pipes.AccessControl => 55
	i32 u0xa3c818c7, ; 631: lib_System.Net.WebSockets.Client.dll.so => 80
	i32 u0xa3cc7fa7, ; 632: System.Runtime.InteropServices.JavaScript => 106
	i32 u0xa4672f3b, ; 633: Microsoft.Maui.Controls.Xaml => 189
	i32 u0xa493aa02, ; 634: lib_System.Collections.Concurrent.dll.so => 8
	i32 u0xa4caf7a7, ; 635: Microsoft.Maui.dll => 190
	i32 u0xa4d4aaf8, ; 636: lib_System.Security.Cryptography.Cng.dll.so => 121
	i32 u0xa4db22c6, ; 637: System.Text.Encoding.CodePages.dll => 134
	i32 u0xa4e79dfd, ; 638: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 245
	i32 u0xa522693c, ; 639: Xamarin.Jetbrains.Annotations.dll => 281
	i32 u0xa52ac270, ; 640: lib_Xamarin.AndroidX.Window.dll.so => 269
	i32 u0xa553c739, ; 641: lib_System.ValueTuple.dll.so => 152
	i32 u0xa5a0a402, ; 642: Xamarin.AndroidX.ViewPager.dll => 267
	i32 u0xa5b3182d, ; 643: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 255
	i32 u0xa5b67c07, ; 644: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 235
	i32 u0xa5c5753c, ; 645: lib_System.Collections.Immutable.dll.so => 9
	i32 u0xa5ea80d9, ; 646: lib_Xamarin.Android.Glide.Annotations.dll.so => 199
	i32 u0xa6133c7f, ; 647: lib_System.IO.FileSystem.DriveInfo.dll.so => 48
	i32 u0xa630ecdd, ; 648: Xamarin.AndroidX.Fragment.Ktx.dll => 232
	i32 u0xa668c988, ; 649: lib_System.Net.NameResolution.dll.so => 68
	i32 u0xa685bd50, ; 650: Xamarin.Google.ErrorProne.TypeAnnotations.dll => 275
	i32 u0xa7008e0b, ; 651: Microsoft.Maui.Graphics => 192
	i32 u0xa7042ae3, ; 652: uk/Microsoft.Maui.Controls.resources => 320
	i32 u0xa715dd7e, ; 653: System.Xml.XPath.XDocument.dll => 160
	i32 u0xa741ef0b, ; 654: es/Microsoft.Maui.Controls.resources.dll => 297
	i32 u0xa744f665, ; 655: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 251
	i32 u0xa78103bc, ; 656: Xamarin.AndroidX.CoordinatorLayout.dll => 219
	i32 u0xa8032c67, ; 657: lib_Microsoft.Win32.Registry.dll.so => 5
	i32 u0xa80db4e1, ; 658: System.Xml.dll => 164
	i32 u0xa81b119f, ; 659: lib_System.Security.Cryptography.dll.so => 127
	i32 u0xa8282c09, ; 660: System.ServiceProcess.dll => 133
	i32 u0xa8298928, ; 661: Xamarin.AndroidX.ResourceInspection.Annotation => 255
	i32 u0xa85a7b6c, ; 662: System.Xml.XmlDocument => 162
	i32 u0xa8c61dcb, ; 663: nl/Microsoft.Maui.Controls.resources.dll => 310
	i32 u0xa9379a4f, ; 664: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 246
	i32 u0xa9b829f7, ; 665: Xamarin.GooglePlayServices.Base => 277
	i32 u0xa9d96f9b, ; 666: System.Threading.Overlapped.dll => 141
	i32 u0xaa107fc4, ; 667: Xamarin.AndroidX.ViewPager => 267
	i32 u0xaa2b531f, ; 668: lib_System.Globalization.dll.so => 42
	i32 u0xaa36a797, ; 669: Xamarin.AndroidX.Transition => 263
	i32 u0xaa4e51ff, ; 670: el/Microsoft.Maui.Controls.resources => 296
	i32 u0xaa88e550, ; 671: Mono.Android.Export.dll => 170
	i32 u0xaa8a4878, ; 672: Microsoft.Maui.Essentials => 191
	i32 u0xaaf9aad7, ; 673: CommunityToolkit.Maui.Core => 176
	i32 u0xab123e9a, ; 674: Xamarin.AndroidX.Activity.Ktx.dll => 203
	i32 u0xab5f85c3, ; 675: Jsr305Binding.dll => 272
	i32 u0xab606289, ; 676: System.Globalization.Calendars.dll => 40
	i32 u0xabbc23e8, ; 677: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 290
	i32 u0xabdea79a, ; 678: ru/Microsoft.Maui.Controls.resources => 315
	i32 u0xabf58099, ; 679: Xamarin.AndroidX.ExifInterface => 230
	i32 u0xac1dd496, ; 680: System.Net.dll => 82
	i32 u0xacd6baa9, ; 681: System.IO.UnmanagedMemoryStream => 57
	i32 u0xace3f9b4, ; 682: System.Dynamic.Runtime.dll => 37
	i32 u0xace7ba82, ; 683: lib_System.Security.Principal.Windows.dll.so => 128
	i32 u0xacf080de, ; 684: System.Reflection => 98
	i32 u0xad2a79b6, ; 685: mscorlib.dll => 167
	i32 u0xad6f1e8a, ; 686: System.Private.CoreLib => 173
	i32 u0xad90894d, ; 687: lib_Xamarin.KotlinX.Serialization.Core.dll.so => 289
	i32 u0xaddb6d38, ; 688: Xamarin.AndroidX.ViewPager2.dll => 268
	i32 u0xae037813, ; 689: System.Numerics.Vectors.dll => 83
	i32 u0xae1ce33f, ; 690: Xamarin.AndroidX.Annotation.Experimental.dll => 205
	i32 u0xaeb2d8a5, ; 691: lib_Microsoft.Extensions.Options.dll.so => 185
	i32 u0xaf06273c, ; 692: System.Resources.Reader => 99
	i32 u0xaf3a6b91, ; 693: lib_System.Diagnostics.Debug.dll.so => 26
	i32 u0xaf4af872, ; 694: System.Diagnostics.StackTrace.dll => 30
	i32 u0xaf624531, ; 695: System.Xml.XPath.XDocument => 160
	i32 u0xaf8b1081, ; 696: lib_Xamarin.AndroidX.SavedState.SavedState.Ktx.dll.so => 257
	i32 u0xb0682092, ; 697: System.ComponentModel.dll => 18
	i32 u0xb0ed41f3, ; 698: System.Security.Principal.Windows => 128
	i32 u0xb128f886, ; 699: System.Security.Cryptography.Algorithms.dll => 120
	i32 u0xb18af942, ; 700: Xamarin.AndroidX.DrawerLayout => 226
	i32 u0xb1a434a2, ; 701: lib_System.Xml.Linq.dll.so => 156
	i32 u0xb1a7d210, ; 702: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll.so => 243
	i32 u0xb21220a3, ; 703: Xamarin.AndroidX.Security.SecurityCrypto => 258
	i32 u0xb223fa8c, ; 704: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 293
	i32 u0xb28cab85, ; 705: lib_Xamarin.Android.Glide.DiskLruCache.dll.so => 200
	i32 u0xb294d40b, ; 706: lib_System.Net.Ping.dll.so => 70
	i32 u0xb2a03f9f, ; 707: Xamarin.AndroidX.Lifecycle.Process.dll => 239
	i32 u0xb3d3821c, ; 708: Xamarin.AndroidX.Startup.StartupRuntime => 260
	i32 u0xb3d4efc5, ; 709: Xamarin.GooglePlayServices.Maps => 279
	i32 u0xb434b64b, ; 710: WindowsBase.dll => 166
	i32 u0xb514b305, ; 711: _Microsoft.Android.Resource.Designer.dll => 329
	i32 u0xb58d85d9, ; 712: lib_System.Runtime.Handles.dll.so => 105
	i32 u0xb62a9ccb, ; 713: Xamarin.AndroidX.SavedState.SavedState.Ktx => 257
	i32 u0xb63fa9f0, ; 714: Xamarin.AndroidX.Navigation.Common => 249
	i32 u0xb646e70c, ; 715: Xamarin.GooglePlayServices.Tasks => 280
	i32 u0xb6490b5e, ; 716: lib_Mono.Android.Export.dll.so => 170
	i32 u0xb65adef9, ; 717: Mono.Android.Runtime => 171
	i32 u0xb65daa69, ; 718: lib_StreetLightApp.dll.so => 0
	i32 u0xb660be12, ; 719: System.ComponentModel.Primitives => 16
	i32 u0xb6a153b2, ; 720: lib_Xamarin.AndroidX.ViewPager2.dll.so => 268
	i32 u0xb70c6fb4, ; 721: lib_Xamarin.AndroidX.VectorDrawable.dll.so => 264
	i32 u0xb755818f, ; 722: System.Threading.Tasks => 145
	i32 u0xb76be845, ; 723: hu/Microsoft.Maui.Controls.resources.dll => 303
	i32 u0xb7e7c341, ; 724: lib_System.Globalization.Calendars.dll.so => 40
	i32 u0xb838e2b0, ; 725: System.Security.Cryptography.X509Certificates.dll => 126
	i32 u0xb8c22b7f, ; 726: System.Security.Claims.dll => 119
	i32 u0xb8fd311b, ; 727: System.Formats.Asn1 => 38
	i32 u0xb979e222, ; 728: System.Runtime.Serialization => 116
	i32 u0xba0dbf1c, ; 729: System.IO.FileSystem.AccessControl.dll => 47
	i32 u0xba4127cb, ; 730: System.Threading.Tasks.Extensions => 143
	i32 u0xbaa520e7, ; 731: lib_System.ObjectModel.dll.so => 85
	i32 u0xbab301d1, ; 732: System.Security.AccessControl => 118
	i32 u0xbb95ee37, ; 733: System.Diagnostics.Tracing.dll => 34
	i32 u0xbba64c02, ; 734: GoogleGson.dll => 177
	i32 u0xbc4c6465, ; 735: System.Reflection.Primitives.dll => 96
	i32 u0xbc652da7, ; 736: System.IO.MemoryMappedFiles => 53
	i32 u0xbc98c93d, ; 737: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 214
	i32 u0xbcc610a0, ; 738: lib_System.Reflection.Metadata.dll.so => 95
	i32 u0xbd113355, ; 739: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 249
	i32 u0xbd78b0c8, ; 740: Xamarin.AndroidX.Navigation.Fragment.dll => 250
	i32 u0xbddce8a2, ; 741: lib_System.Security.Principal.dll.so => 129
	i32 u0xbe3f07c2, ; 742: lib_System.Runtime.CompilerServices.Unsafe.dll.so => 102
	i32 u0xbe4755f4, ; 743: System.Security.SecureString => 130
	i32 u0xbe592c0c, ; 744: System.Web => 154
	i32 u0xbefef58f, ; 745: System.Data.dll => 24
	i32 u0xbf506931, ; 746: System.Xml.XmlDocument.dll => 162
	i32 u0xbfc8f642, ; 747: Microsoft.VisualStudio.DesignTools.XamlTapContract => 328
	i32 u0xbff2e236, ; 748: System.Threading => 149
	i32 u0xc00e375b, ; 749: lib_Newtonsoft.Json.dll.so => 195
	i32 u0xc04c3c0a, ; 750: System.Runtime.Handles.dll => 105
	i32 u0xc08d007e, ; 751: Xamarin.GooglePlayServices.Basement.dll => 278
	i32 u0xc095e070, ; 752: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 234
	i32 u0xc10b79a7, ; 753: Xamarin.AndroidX.Core.ViewTree => 222
	i32 u0xc1abc74d, ; 754: RestSharp.dll => 196
	i32 u0xc1c6ebf4, ; 755: System.Reflection.DispatchProxy.dll => 90
	i32 u0xc217efb6, ; 756: lib_Xamarin.AndroidX.ConstraintLayout.Core.dll.so => 218
	i32 u0xc235e84d, ; 757: Xamarin.AndroidX.CardView => 212
	i32 u0xc2a37b91, ; 758: System.Linq.Queryable.dll => 61
	i32 u0xc2a993fa, ; 759: System.Threading.Tasks.Extensions.dll => 143
	i32 u0xc3428433, ; 760: lib_System.Reflection.Emit.ILGeneration.dll.so => 91
	i32 u0xc35f7fa4, ; 761: System.Resources.Writer.dll => 101
	i32 u0xc37f65ce, ; 762: Microsoft.Win32.Registry.dll => 5
	i32 u0xc3888e16, ; 763: System.ComponentModel.Annotations.dll => 13
	i32 u0xc3ba1d80, ; 764: lib_System.Security.Cryptography.Csp.dll.so => 122
	i32 u0xc4251ff9, ; 765: System.Security.Cryptography.Encoding => 123
	i32 u0xc4684d9e, ; 766: lib_System.Security.Cryptography.Algorithms.dll.so => 120
	i32 u0xc4a8494a, ; 767: System.Text.Encoding => 136
	i32 u0xc4e76306, ; 768: System.Diagnostics.FileVersionInfo => 28
	i32 u0xc591efe9, ; 769: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 179
	i32 u0xc5b097e4, ; 770: System.Net.Requests.dll => 73
	i32 u0xc5b776df, ; 771: Xamarin.AndroidX.CustomView.dll => 224
	i32 u0xc5b79d28, ; 772: System.Data => 24
	i32 u0xc69f3b41, ; 773: lib_System.Data.dll.so => 24
	i32 u0xc71af05d, ; 774: Xamarin.AndroidX.Arch.Core.Runtime => 210
	i32 u0xc76e512c, ; 775: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 253
	i32 u0xc774da4f, ; 776: Xamarin.AndroidX.Navigation.Runtime => 251
	i32 u0xc7a3b0f0, ; 777: lib_Xamarin.AndroidX.Transition.dll.so => 263
	i32 u0xc7b797d0, ; 778: lib_Xamarin.AndroidX.Core.Core.Ktx.dll.so => 221
	i32 u0xc821fc10, ; 779: lib_System.ComponentModel.dll.so => 18
	i32 u0xc82afec1, ; 780: System.Text.Json => 138
	i32 u0xc8693088, ; 781: Xamarin.AndroidX.Activity.Ktx => 203
	i32 u0xc86c06e3, ; 782: Xamarin.AndroidX.Core => 220
	i32 u0xc8a662e9, ; 783: Java.Interop => 169
	i32 u0xc8d10307, ; 784: lib_System.Diagnostics.TraceSource.dll.so => 33
	i32 u0xc92a6809, ; 785: Xamarin.AndroidX.RecyclerView => 254
	i32 u0xca5de1fa, ; 786: System.Runtime.CompilerServices.Unsafe.dll => 102
	i32 u0xcae37e41, ; 787: System.Security.Cryptography.OpenSsl.dll => 124
	i32 u0xcaf7bd4b, ; 788: Xamarin.AndroidX.CustomView.PoolingContainer => 225
	i32 u0xcb5af55c, ; 789: lib_System.Reflection.Emit.Lightweight.dll.so => 92
	i32 u0xcc5af6ee, ; 790: Microsoft.Extensions.DependencyInjection.dll => 180
	i32 u0xcc6479a0, ; 791: System.Xml => 164
	i32 u0xcc7d82b4, ; 792: netstandard => 168
	i32 u0xcd1dd0db, ; 793: Xamarin.AndroidX.DynamicAnimation.dll => 227
	i32 u0xcd5a809f, ; 794: System.Formats.Tar => 39
	i32 u0xcdd8cd54, ; 795: lib_Xamarin.AndroidX.Emoji2.dll.so => 228
	i32 u0xce3fa116, ; 796: lib_System.Diagnostics.Process.dll.so => 29
	i32 u0xce70fda2, ; 797: hr/Microsoft.Maui.Controls.resources.dll => 302
	i32 u0xcef19b37, ; 798: System.ComponentModel.TypeConverter.dll => 17
	i32 u0xcf3163e6, ; 799: Mono.Android => 172
	i32 u0xcf663a21, ; 800: ru/Microsoft.Maui.Controls.resources.dll => 315
	i32 u0xcfa20c36, ; 801: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 261
	i32 u0xcfbaacae, ; 802: System.Text.Json.dll => 138
	i32 u0xcfd0c798, ; 803: System.Transactions => 151
	i32 u0xd0418592, ; 804: Xamarin.AndroidX.Concurrent.Futures.dll => 216
	i32 u0xd0a98ee2, ; 805: Microsoft.Maui.Controls.Maps => 188
	i32 u0xd0f73226, ; 806: lib_Xamarin.KotlinX.AtomicFU.Jvm.dll.so => 285
	i32 u0xd128d608, ; 807: System.Xml.Linq => 156
	i32 u0xd1854eb4, ; 808: System.Security.dll => 131
	i32 u0xd2757232, ; 809: System.Configuration => 19
	i32 u0xd2ff69f1, ; 810: System.Net.HttpListener => 66
	i32 u0xd310c033, ; 811: lib_Xamarin.Jetbrains.Annotations.dll.so => 281
	i32 u0xd328ac54, ; 812: vi/Microsoft.Maui.Controls.resources => 321
	i32 u0xd4045e1b, ; 813: lib_System.dll.so => 165
	i32 u0xd404ddfe, ; 814: lib_System.Runtime.Intrinsics.dll.so => 109
	i32 u0xd432d20b, ; 815: System.Threading.Timer => 148
	i32 u0xd457e5c9, ; 816: lib_Microsoft.CSharp.dll.so => 1
	i32 u0xd45fd3d5, ; 817: WatsonWebsocket.dll => 197
	i32 u0xd47cb45a, ; 818: lib_Xamarin.AndroidX.Arch.Core.Common.dll.so => 209
	i32 u0xd496c3c3, ; 819: lib_Xamarin.AndroidX.ExifInterface.dll.so => 230
	i32 u0xd4d2575b, ; 820: System.IO.FileSystem.AccessControl => 47
	i32 u0xd505225a, ; 821: lib_System.Xml.XPath.dll.so => 161
	i32 u0xd622b752, ; 822: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 314
	i32 u0xd664cdf2, ; 823: de/Microsoft.Maui.Controls.resources => 295
	i32 u0xd6665034, ; 824: Xamarin.Android.Glide.GifDecoder.dll => 201
	i32 u0xd67a52b3, ; 825: System.Net.WebSockets.Client => 80
	i32 u0xd715a361, ; 826: System.Linq.dll => 62
	i32 u0xd77927f1, ; 827: StreetLightApp => 0
	i32 u0xd7f95f5a, ; 828: da/Microsoft.Maui.Controls.resources => 294
	i32 u0xd804d57a, ; 829: System.Runtime.InteropServices.RuntimeInformation => 107
	i32 u0xd889aee8, ; 830: lib_System.Threading.Channels.dll.so => 140
	i32 u0xd8950487, ; 831: Xamarin.AndroidX.Annotation.Experimental => 205
	i32 u0xd8bba49d, ; 832: lib_Xamarin.AndroidX.RecyclerView.dll.so => 254
	i32 u0xd8dbab5d, ; 833: System.IO.FileSystem.Primitives.dll => 49
	i32 u0xd90e5f5a, ; 834: Xamarin.AndroidX.Lifecycle.LiveData.Core => 237
	i32 u0xd92e86f1, ; 835: Xamarin.KotlinX.Serialization.Core.dll => 289
	i32 u0xd930cda0, ; 836: Xamarin.AndroidX.Navigation.Fragment => 250
	i32 u0xd943a729, ; 837: System.ComponentModel.DataAnnotations => 14
	i32 u0xd96cf6f7, ; 838: pt-BR/Microsoft.Maui.Controls.resources => 312
	i32 u0xd9f65f5e, ; 839: lib-el-Microsoft.Maui.Controls.resources.dll.so => 296
	i32 u0xd9fdda56, ; 840: Microsoft.Extensions.Configuration.Abstractions.dll => 179
	i32 u0xda2f27df, ; 841: System.Net.NetworkInformation => 69
	i32 u0xda4773dd, ; 842: he/Microsoft.Maui.Controls.resources => 300
	i32 u0xdabf74ac, ; 843: lib_Xamarin.AndroidX.Annotation.Jvm.dll.so => 206
	i32 u0xdae8aa5e, ; 844: Mono.Android.dll => 172
	i32 u0xdb258bb2, ; 845: Microsoft.Maui.Controls.HotReload.Forms => 325
	i32 u0xdb7f7e5d, ; 846: Xamarin.AndroidX.Browser => 211
	i32 u0xdb9df1ce, ; 847: Xamarin.AndroidX.Concurrent.Futures => 216
	i32 u0xdbb50d93, ; 848: ms/Microsoft.Maui.Controls.resources => 308
	i32 u0xdc5370c5, ; 849: lib_System.Web.HttpUtility.dll.so => 153
	i32 u0xdc68940c, ; 850: zh-Hant/Microsoft.Maui.Controls.resources.dll => 324
	i32 u0xdc96bdf5, ; 851: System.Net.WebProxy.dll => 79
	i32 u0xdcefb51d, ; 852: Xamarin.AndroidX.Core.Core.Ktx.dll => 221
	i32 u0xdd864306, ; 853: System.Runtime.Intrinsics => 109
	i32 u0xdda814c6, ; 854: Xamarin.AndroidX.Annotation => 204
	i32 u0xde068c70, ; 855: Xamarin.AndroidX.Navigation.Common.dll => 249
	i32 u0xde7354ab, ; 856: System.Net.NameResolution => 68
	i32 u0xdecad304, ; 857: System.Net.Http.Json.dll => 64
	i32 u0xdf1b1ecd, ; 858: lib_System.ServiceProcess.dll.so => 133
	i32 u0xdf6f3870, ; 859: System.Diagnostics.DiagnosticSource => 27
	i32 u0xdf9a7f42, ; 860: System.Xml.XPath => 161
	i32 u0xdfd65a5d, ; 861: lib_System.Diagnostics.Tracing.dll.so => 34
	i32 u0xe05b6245, ; 862: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll => 243
	i32 u0xe0dec2ee, ; 863: lib_CommunityToolkit.Maui.dll.so => 175
	i32 u0xe12f62fc, ; 864: lib_System.Threading.ThreadPool.dll.so => 147
	i32 u0xe13414bb, ; 865: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 303
	i32 u0xe1a41194, ; 866: lib_System.Xml.XDocument.dll.so => 159
	i32 u0xe1ae15d6, ; 867: Xamarin.AndroidX.Collection => 213
	i32 u0xe1eea3e4, ; 868: lib_System.IO.Compression.ZipFile.dll.so => 45
	i32 u0xe1f0a5d8, ; 869: lib_Xamarin.AndroidX.ViewPager.dll.so => 267
	i32 u0xe2098b0b, ; 870: System.Collections.NonGeneric => 10
	i32 u0xe2197fa1, ; 871: AsyncAwaitBestPractices.dll => 174
	i32 u0xe250cda6, ; 872: lib_Microsoft.Extensions.Logging.dll.so => 182
	i32 u0xe2513246, ; 873: lib_System.Runtime.Numerics.dll.so => 111
	i32 u0xe27c1b41, ; 874: lib_Xamarin.KotlinX.AtomicFU.dll.so => 284
	i32 u0xe2a3f2e8, ; 875: System.Collections.Specialized.dll => 11
	i32 u0xe34ee011, ; 876: lib_System.IO.Pipelines.dll.so => 54
	i32 u0xe3774f52, ; 877: lib_System.IO.MemoryMappedFiles.dll.so => 53
	i32 u0xe37a36df, ; 878: RestSharp => 196
	i32 u0xe3886bf7, ; 879: CommunityToolkit.Maui.dll => 175
	i32 u0xe3a54a09, ; 880: System.Net.WebProxy => 79
	i32 u0xe3c7860c, ; 881: lib_System.Security.Claims.dll.so => 119
	i32 u0xe3df9d2b, ; 882: System.Security.Cryptography.dll => 127
	i32 u0xe4436460, ; 883: System.Numerics.dll => 84
	i32 u0xe4fab729, ; 884: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 181
	i32 u0xe52378b9, ; 885: System.Net.Mail.dll => 67
	i32 u0xe56ef253, ; 886: System.Runtime.InteropServices.dll => 108
	i32 u0xe625b819, ; 887: lib_Xamarin.AndroidX.CardView.dll.so => 212
	i32 u0xe6b14171, ; 888: System.Net.HttpListener.dll => 66
	i32 u0xe6ca3640, ; 889: lib_Xamarin.AndroidX.Collection.Ktx.dll.so => 215
	i32 u0xe6e179fa, ; 890: System.Security.Principal => 129
	i32 u0xe6f98713, ; 891: System.Security.Cryptography.Encoding.dll => 123
	i32 u0xe797fcc1, ; 892: System.Net.WebHeaderCollection.dll => 78
	i32 u0xe79e77a6, ; 893: Xamarin.AndroidX.Transition.dll => 263
	i32 u0xe7c9e2bd, ; 894: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 253
	i32 u0xe7dc15ff, ; 895: zh-Hans/Microsoft.Maui.Controls.resources.dll => 323
	i32 u0xe839deed, ; 896: System.Collections.Concurrent.dll => 8
	i32 u0xe843daa0, ; 897: Xamarin.AndroidX.Core.dll => 220
	i32 u0xe89260c1, ; 898: Microsoft.VisualBasic.Core.dll => 2
	i32 u0xe90fdb70, ; 899: Xamarin.AndroidX.Collection.Jvm => 214
	i32 u0xe92ace5f, ; 900: lib_System.Linq.Parallel.dll.so => 60
	i32 u0xe99f7d24, ; 901: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 319
	i32 u0xe9b2d35e, ; 902: System.IO.Compression.FileSystem.dll => 44
	i32 u0xe9b630ed, ; 903: Xamarin.AndroidX.VersionedParcelable.dll => 266
	i32 u0xea0092d6, ; 904: lib_System.Threading.Tasks.Extensions.dll.so => 143
	i32 u0xea213423, ; 905: System.Xml.ReaderWriter => 157
	i32 u0xea4780ec, ; 906: System.Security.Principal.dll => 129
	i32 u0xea4fb52e, ; 907: Xamarin.AndroidX.Navigation.UI => 252
	i32 u0xeab81858, ; 908: lib_Microsoft.Maui.Essentials.dll.so => 191
	i32 u0xeaf244cc, ; 909: lib_System.IO.Pipes.AccessControl.dll.so => 55
	i32 u0xeaf598f6, ; 910: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 183
	i32 u0xeb2ecede, ; 911: System.Data.DataSetExtensions.dll => 23
	i32 u0xeb5560c9, ; 912: lib_System.Runtime.InteropServices.RuntimeInformation.dll.so => 107
	i32 u0xebac8bfe, ; 913: System.Text.Encoding.CodePages => 134
	i32 u0xebb0254b, ; 914: lib_System.Net.NetworkInformation.dll.so => 69
	i32 u0xebc66336, ; 915: Xamarin.AndroidX.AppCompat.dll => 207
	i32 u0xec05582d, ; 916: Xamarin.AndroidX.Lifecycle.Process => 239
	i32 u0xeca1adaf, ; 917: Xamarin.GooglePlayServices.Tasks.dll => 280
	i32 u0xed1090ae, ; 918: lib_System.Net.Primitives.dll.so => 71
	i32 u0xed409aea, ; 919: th/Microsoft.Maui.Controls.resources.dll => 318
	i32 u0xed96d41f, ; 920: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 219
	i32 u0xedadd6e2, ; 921: he/Microsoft.Maui.Controls.resources.dll => 300
	i32 u0xedf6669b, ; 922: lib_System.Drawing.dll.so => 36
	i32 u0xee9f991d, ; 923: System.Diagnostics.Process.dll => 29
	i32 u0xeeefb9c8, ; 924: lib_System.Dynamic.Runtime.dll.so => 37
	i32 u0xef5e8475, ; 925: Xamarin.AndroidX.Annotation.Jvm.dll => 206
	i32 u0xefd01a89, ; 926: System.IO.Pipelines => 54
	i32 u0xeff49a63, ; 927: System.Memory => 63
	i32 u0xeff49c4a, ; 928: lib_System.Text.Encoding.Extensions.dll.so => 135
	i32 u0xf04057de, ; 929: Mopups => 194
	i32 u0xf09122fc, ; 930: lib_System.IO.IsolatedStorage.dll.so => 52
	i32 u0xf0ba55d9, ; 931: lib_Microsoft.Maui.Controls.HotReload.Forms.dll.so => 325
	i32 u0xf121f953, ; 932: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 237
	i32 u0xf1304331, ; 933: Microsoft.Maui.Controls.Xaml.dll => 189
	i32 u0xf15cb56d, ; 934: Xamarin.KotlinX.Serialization.Core => 289
	i32 u0xf1676aaa, ; 935: lib-da-Microsoft.Maui.Controls.resources.dll.so => 294
	i32 u0xf1ad867b, ; 936: System.Reflection.Emit.ILGeneration => 91
	i32 u0xf27f60d1, ; 937: System.Private.Xml.Linq.dll => 88
	i32 u0xf29c5384, ; 938: id/Microsoft.Maui.Controls.resources => 304
	i32 u0xf2ce3c98, ; 939: System.Threading.dll => 149
	i32 u0xf2dd3fc4, ; 940: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 306
	i32 u0xf323e0a6, ; 941: lib_Xamarin.Kotlin.StdLib.dll.so => 283
	i32 u0xf33c42ef, ; 942: lib_Xamarin.AndroidX.VectorDrawable.Animated.dll.so => 265
	i32 u0xf3a16066, ; 943: lib_Xamarin.AndroidX.Lifecycle.ViewModel.dll.so => 244
	i32 u0xf40add04, ; 944: Microsoft.Maui.Essentials.dll => 191
	i32 u0xf42589bc, ; 945: lib_System.Security.Cryptography.X509Certificates.dll.so => 126
	i32 u0xf45985cf, ; 946: System.Drawing.dll => 36
	i32 u0xf462c30d, ; 947: System.Private.Uri => 87
	i32 u0xf479582c, ; 948: Xamarin.AndroidX.Emoji2 => 228
	i32 u0xf47b0a29, ; 949: lib_System.Configuration.dll.so => 19
	i32 u0xf48143e5, ; 950: pt/Microsoft.Maui.Controls.resources.dll => 313
	i32 u0xf5185c24, ; 951: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 313
	i32 u0xf53cb11d, ; 952: lib_System.Net.Security.dll.so => 74
	i32 u0xf5861a4f, ; 953: pl/Microsoft.Maui.Controls.resources => 311
	i32 u0xf5e94e90, ; 954: ms/Microsoft.Maui.Controls.resources.dll => 308
	i32 u0xf5f4f1f0, ; 955: Microsoft.Extensions.DependencyInjection => 180
	i32 u0xf5fdf056, ; 956: lib_Microsoft.Extensions.DependencyInjection.dll.so => 180
	i32 u0xf60736e2, ; 957: System.IO.FileSystem.Watcher => 50
	i32 u0xf6318da0, ; 958: System.AppContext => 6
	i32 u0xf73be021, ; 959: System.Reflection.Emit.ILGeneration.dll => 91
	i32 u0xf76edc75, ; 960: System.Core => 21
	i32 u0xf798e6c6, ; 961: WatsonWebsocket => 197
	i32 u0xf7e95c85, ; 962: System.Xml.XmlSerializer => 163
	i32 u0xf807b767, ; 963: System.Reflection.TypeExtensions => 97
	i32 u0xf83dd773, ; 964: System.IO.FileSystem.Watcher.dll => 50
	i32 u0xf8420da3, ; 965: lib_Microsoft.VisualStudio.DesignTools.TapContract.dll.so => 327
	i32 u0xf86129d4, ; 966: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 317
	i32 u0xf93ba7d4, ; 967: System.Runtime.Serialization.Primitives => 114
	i32 u0xf94a8f86, ; 968: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 247
	i32 u0xf951b10e, ; 969: Microsoft.VisualStudio.DesignTools.MobileTapContracts => 326
	i32 u0xf97c5a99, ; 970: System.Security => 131
	i32 u0xf9cd7515, ; 971: Microsoft.Maui.Maps.dll => 193
	i32 u0xfa21f6af, ; 972: System.Net.WebClient.dll => 77
	i32 u0xfa50891f, ; 973: lib_System.Linq.dll.so => 62
	i32 u0xfa6ae1e2, ; 974: lib_Xamarin.AndroidX.Annotation.dll.so => 204
	i32 u0xfb0af295, ; 975: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 322
	i32 u0xfb1dad5d, ; 976: System.Diagnostics.DiagnosticSource.dll => 27
	i32 u0xfbc4b67c, ; 977: lib_System.IO.Compression.Brotli.dll.so => 43
	i32 u0xfc0a7526, ; 978: Xamarin.KotlinX.AtomicFU.Jvm.dll => 285
	i32 u0xfc5f7d36, ; 979: pt/Microsoft.Maui.Controls.resources => 313
	i32 u0xfdaee526, ; 980: Xamarin.AndroidX.Core.Core.Ktx => 221
	i32 u0xfdd1b433, ; 981: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 246
	i32 u0xfdf2741f, ; 982: System.Buffers => 7
	i32 u0xfe42d509, ; 983: lib_Xamarin.AndroidX.Security.SecurityCrypto.dll.so => 258
	i32 u0xfea12dee, ; 984: Microsoft.Maui.Controls.dll => 187
	i32 u0xfecef6ea, ; 985: System.Runtime.Numerics => 111
	i32 u0xfeff2639, ; 986: Xamarin.GooglePlayServices.Maps.dll => 279
	i32 u0xff912ee3, ; 987: lib_System.Xml.Serialization.dll.so => 158
	i32 u0xffd4917f, ; 988: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 247
	i32 u0xfffce3e8 ; 989: Xamarin.AndroidX.ExifInterface.dll => 230
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [990 x i32] [
	i32 69, i32 73, i32 68, i32 248, i32 163, i32 109, i32 181, i32 240,
	i32 276, i32 48, i32 195, i32 81, i32 320, i32 146, i32 285, i32 190,
	i32 292, i32 30, i32 125, i32 192, i32 103, i32 10, i32 259, i32 61,
	i32 322, i32 276, i32 67, i32 108, i32 259, i32 140, i32 31, i32 78,
	i32 125, i32 13, i32 216, i32 213, i32 284, i32 202, i32 133, i32 196,
	i32 261, i32 262, i32 321, i32 271, i32 152, i32 160, i32 64, i32 311,
	i32 321, i32 75, i32 322, i32 18, i32 328, i32 211, i32 44, i32 26,
	i32 184, i32 1, i32 222, i32 224, i32 60, i32 42, i32 309, i32 92,
	i32 130, i32 198, i32 217, i32 148, i32 236, i32 233, i32 293, i32 23,
	i32 316, i32 55, i32 70, i32 202, i32 84, i32 273, i32 117, i32 306,
	i32 234, i32 13, i32 305, i32 293, i32 132, i32 178, i32 110, i32 56,
	i32 326, i32 150, i32 75, i32 146, i32 63, i32 147, i32 255, i32 329,
	i32 166, i32 241, i32 123, i32 317, i32 218, i32 12, i32 231, i32 126,
	i32 153, i32 242, i32 171, i32 114, i32 167, i32 169, i32 165, i32 233,
	i32 87, i32 259, i32 116, i32 85, i32 304, i32 298, i32 186, i32 125,
	i32 6, i32 151, i32 301, i32 61, i32 182, i32 51, i32 104, i32 115,
	i32 40, i32 282, i32 272, i32 222, i32 270, i32 121, i32 312, i32 177,
	i32 132, i32 11, i32 175, i32 52, i32 21, i32 44, i32 76, i32 120,
	i32 194, i32 241, i32 224, i32 229, i32 225, i32 94, i32 295, i32 176,
	i32 82, i32 193, i32 137, i32 266, i32 22, i32 209, i32 8, i32 51,
	i32 312, i32 284, i32 74, i32 292, i32 156, i32 286, i32 223, i32 155,
	i32 164, i32 93, i32 281, i32 45, i32 307, i32 295, i32 275, i32 279,
	i32 110, i32 131, i32 130, i32 25, i32 199, i32 162, i32 73, i32 56,
	i32 46, i32 98, i32 185, i32 90, i32 225, i32 22, i32 238, i32 146,
	i32 87, i32 0, i32 43, i32 161, i32 72, i32 226, i32 291, i32 3,
	i32 42, i32 64, i32 56, i32 274, i32 16, i32 58, i32 193, i32 278,
	i32 53, i32 151, i32 41, i32 319, i32 276, i32 14, i32 245, i32 229,
	i32 106, i32 235, i32 195, i32 167, i32 273, i32 234, i32 34, i32 159,
	i32 286, i32 86, i32 32, i32 227, i32 12, i32 323, i32 142, i32 51,
	i32 297, i32 57, i32 256, i32 36, i32 181, i32 294, i32 274, i32 207,
	i32 35, i32 233, i32 59, i32 97, i32 244, i32 12, i32 99, i32 186,
	i32 239, i32 177, i32 17, i32 283, i32 165, i32 174, i32 93, i32 137,
	i32 201, i32 242, i32 184, i32 318, i32 124, i32 17, i32 79, i32 83,
	i32 269, i32 65, i32 86, i32 155, i32 154, i32 265, i32 251, i32 298,
	i32 141, i32 101, i32 311, i32 209, i32 29, i32 52, i32 213, i32 148,
	i32 309, i32 301, i32 270, i32 214, i32 282, i32 5, i32 192, i32 290,
	i32 260, i32 287, i32 88, i32 264, i32 115, i32 215, i32 286, i32 206,
	i32 226, i32 253, i32 86, i32 270, i32 269, i32 62, i32 113, i32 302,
	i32 292, i32 58, i32 256, i32 100, i32 173, i32 50, i32 19, i32 219,
	i32 112, i32 102, i32 32, i32 3, i32 103, i32 84, i32 105, i32 273,
	i32 235, i32 197, i32 72, i32 4, i32 245, i32 38, i32 32, i32 57,
	i32 104, i32 74, i32 9, i32 124, i32 46, i32 208, i32 186, i32 9,
	i32 43, i32 4, i32 257, i32 301, i32 35, i32 296, i32 31, i32 211,
	i32 139, i32 93, i32 94, i32 316, i32 299, i32 49, i32 142, i32 113,
	i32 290, i32 141, i32 2, i32 317, i32 16, i32 324, i32 116, i32 274,
	i32 158, i32 325, i32 77, i32 80, i32 39, i32 248, i32 37, i32 268,
	i32 210, i32 176, i32 229, i32 223, i32 65, i32 139, i32 15, i32 46,
	i32 157, i32 166, i32 117, i32 288, i32 262, i32 271, i32 194, i32 217,
	i32 48, i32 71, i32 81, i32 282, i32 127, i32 95, i32 122, i32 150,
	i32 26, i32 118, i32 238, i32 98, i32 28, i32 212, i32 103, i32 314,
	i32 188, i32 150, i32 54, i32 170, i32 4, i32 99, i32 38, i32 324,
	i32 33, i32 78, i32 94, i32 261, i32 182, i32 106, i32 21, i32 41,
	i32 207, i32 171, i32 104, i32 231, i32 149, i32 299, i32 248, i32 309,
	i32 277, i32 283, i32 271, i32 287, i32 252, i32 2, i32 303, i32 135,
	i32 112, i32 327, i32 266, i32 183, i32 320, i32 199, i32 59, i32 96,
	i32 217, i32 39, i32 210, i32 327, i32 323, i32 25, i32 95, i32 90,
	i32 100, i32 278, i32 10, i32 208, i32 172, i32 88, i32 49, i32 63,
	i32 77, i32 101, i32 306, i32 258, i32 178, i32 174, i32 47, i32 201,
	i32 7, i32 302, i32 82, i32 244, i32 291, i32 205, i32 198, i32 300,
	i32 305, i32 89, i32 237, i32 155, i32 329, i32 232, i32 33, i32 113,
	i32 117, i32 66, i32 83, i32 275, i32 136, i32 328, i32 20, i32 277,
	i32 11, i32 163, i32 134, i32 307, i32 3, i32 28, i32 307, i32 308,
	i32 272, i32 190, i32 112, i32 314, i32 100, i32 27, i32 15, i32 185,
	i32 7, i32 183, i32 85, i32 59, i32 72, i32 30, i32 288, i32 65,
	i32 265, i32 144, i32 81, i32 315, i32 158, i32 41, i32 246, i32 187,
	i32 118, i32 179, i32 200, i32 299, i32 305, i32 254, i32 310, i32 168,
	i32 318, i32 241, i32 132, i32 76, i32 67, i32 188, i32 173, i32 204,
	i32 144, i32 107, i32 152, i32 298, i32 20, i32 71, i32 236, i32 157,
	i32 319, i32 178, i32 145, i32 122, i32 250, i32 291, i32 128, i32 153,
	i32 228, i32 154, i32 89, i32 326, i32 142, i32 310, i32 215, i32 96,
	i32 231, i32 20, i32 14, i32 260, i32 136, i32 76, i32 60, i32 218,
	i32 168, i32 238, i32 169, i32 187, i32 15, i32 75, i32 138, i32 240,
	i32 6, i32 304, i32 203, i32 23, i32 240, i32 256, i32 316, i32 198,
	i32 189, i32 92, i32 1, i32 280, i32 137, i32 243, i32 242, i32 264,
	i32 135, i32 70, i32 147, i32 114, i32 288, i32 25, i32 232, i32 184,
	i32 89, i32 97, i32 223, i32 227, i32 252, i32 31, i32 45, i32 144,
	i32 236, i32 247, i32 200, i32 110, i32 159, i32 35, i32 287, i32 108,
	i32 22, i32 115, i32 58, i32 139, i32 262, i32 145, i32 119, i32 121,
	i32 220, i32 111, i32 297, i32 202, i32 140, i32 208, i32 55, i32 80,
	i32 106, i32 189, i32 8, i32 190, i32 121, i32 134, i32 245, i32 281,
	i32 269, i32 152, i32 267, i32 255, i32 235, i32 9, i32 199, i32 48,
	i32 232, i32 68, i32 275, i32 192, i32 320, i32 160, i32 297, i32 251,
	i32 219, i32 5, i32 164, i32 127, i32 133, i32 255, i32 162, i32 310,
	i32 246, i32 277, i32 141, i32 267, i32 42, i32 263, i32 296, i32 170,
	i32 191, i32 176, i32 203, i32 272, i32 40, i32 290, i32 315, i32 230,
	i32 82, i32 57, i32 37, i32 128, i32 98, i32 167, i32 173, i32 289,
	i32 268, i32 83, i32 205, i32 185, i32 99, i32 26, i32 30, i32 160,
	i32 257, i32 18, i32 128, i32 120, i32 226, i32 156, i32 243, i32 258,
	i32 293, i32 200, i32 70, i32 239, i32 260, i32 279, i32 166, i32 329,
	i32 105, i32 257, i32 249, i32 280, i32 170, i32 171, i32 0, i32 16,
	i32 268, i32 264, i32 145, i32 303, i32 40, i32 126, i32 119, i32 38,
	i32 116, i32 47, i32 143, i32 85, i32 118, i32 34, i32 177, i32 96,
	i32 53, i32 214, i32 95, i32 249, i32 250, i32 129, i32 102, i32 130,
	i32 154, i32 24, i32 162, i32 328, i32 149, i32 195, i32 105, i32 278,
	i32 234, i32 222, i32 196, i32 90, i32 218, i32 212, i32 61, i32 143,
	i32 91, i32 101, i32 5, i32 13, i32 122, i32 123, i32 120, i32 136,
	i32 28, i32 179, i32 73, i32 224, i32 24, i32 24, i32 210, i32 253,
	i32 251, i32 263, i32 221, i32 18, i32 138, i32 203, i32 220, i32 169,
	i32 33, i32 254, i32 102, i32 124, i32 225, i32 92, i32 180, i32 164,
	i32 168, i32 227, i32 39, i32 228, i32 29, i32 302, i32 17, i32 172,
	i32 315, i32 261, i32 138, i32 151, i32 216, i32 188, i32 285, i32 156,
	i32 131, i32 19, i32 66, i32 281, i32 321, i32 165, i32 109, i32 148,
	i32 1, i32 197, i32 209, i32 230, i32 47, i32 161, i32 314, i32 295,
	i32 201, i32 80, i32 62, i32 0, i32 294, i32 107, i32 140, i32 205,
	i32 254, i32 49, i32 237, i32 289, i32 250, i32 14, i32 312, i32 296,
	i32 179, i32 69, i32 300, i32 206, i32 172, i32 325, i32 211, i32 216,
	i32 308, i32 153, i32 324, i32 79, i32 221, i32 109, i32 204, i32 249,
	i32 68, i32 64, i32 133, i32 27, i32 161, i32 34, i32 243, i32 175,
	i32 147, i32 303, i32 159, i32 213, i32 45, i32 267, i32 10, i32 174,
	i32 182, i32 111, i32 284, i32 11, i32 54, i32 53, i32 196, i32 175,
	i32 79, i32 119, i32 127, i32 84, i32 181, i32 67, i32 108, i32 212,
	i32 66, i32 215, i32 129, i32 123, i32 78, i32 263, i32 253, i32 323,
	i32 8, i32 220, i32 2, i32 214, i32 60, i32 319, i32 44, i32 266,
	i32 143, i32 157, i32 129, i32 252, i32 191, i32 55, i32 183, i32 23,
	i32 107, i32 134, i32 69, i32 207, i32 239, i32 280, i32 71, i32 318,
	i32 219, i32 300, i32 36, i32 29, i32 37, i32 206, i32 54, i32 63,
	i32 135, i32 194, i32 52, i32 325, i32 237, i32 189, i32 289, i32 294,
	i32 91, i32 88, i32 304, i32 149, i32 306, i32 283, i32 265, i32 244,
	i32 191, i32 126, i32 36, i32 87, i32 228, i32 19, i32 313, i32 313,
	i32 74, i32 311, i32 308, i32 180, i32 180, i32 50, i32 6, i32 91,
	i32 21, i32 197, i32 163, i32 97, i32 50, i32 327, i32 317, i32 114,
	i32 247, i32 326, i32 131, i32 193, i32 77, i32 62, i32 204, i32 322,
	i32 27, i32 43, i32 285, i32 313, i32 221, i32 246, i32 7, i32 258,
	i32 187, i32 111, i32 279, i32 158, i32 247, i32 230
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
