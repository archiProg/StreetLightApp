; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [170 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [510 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 88
	i64 u0x0189e6f888271174, ; 1: AsyncAwaitBestPractices.dll => 35
	i64 u0x02123411c4e01926, ; 2: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 84
	i64 u0x022e81ea9c46e03a, ; 3: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i64 u0x02abedc11addc1ed, ; 4: lib_Mono.Android.Runtime.dll.so => 168
	i64 u0x032267b2a94db371, ; 5: lib_Xamarin.AndroidX.AppCompat.dll.so => 67
	i64 u0x043032f1d071fae0, ; 6: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 7: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 8: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0517ef04e06e9f76, ; 9: System.Net.Primitives => 127
	i64 u0x051a3be159e4ef99, ; 10: Xamarin.GooglePlayServices.Tasks => 95
	i64 u0x0565d18c6da3de38, ; 11: Xamarin.AndroidX.RecyclerView => 86
	i64 u0x0581db89237110e9, ; 12: lib_System.Collections.dll.so => 105
	i64 u0x05989cb940b225a9, ; 13: Microsoft.Maui.dll => 53
	i64 u0x0600544dd3961080, ; 14: HarfBuzzSharp => 38
	i64 u0x06076b5d2b581f08, ; 15: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 16: System.Xml.Linq.dll => 160
	i64 u0x0680a433c781bb3d, ; 17: Xamarin.AndroidX.Collection.Jvm => 70
	i64 u0x0709647b42d5e3e6, ; 18: LiveChartsCore => 39
	i64 u0x07c57877c7ba78ad, ; 19: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 20: System.Collections.NonGeneric => 103
	i64 u0x08a7c865576bbde7, ; 21: System.Reflection.Primitives => 142
	i64 u0x08f3c9788ee2153c, ; 22: Xamarin.AndroidX.DrawerLayout => 75
	i64 u0x0919c28b89381a0b, ; 23: lib_Microsoft.Extensions.Options.dll.so => 48
	i64 u0x092266563089ae3e, ; 24: lib_System.Collections.NonGeneric.dll.so => 103
	i64 u0x098b50f911ccea8d, ; 25: lib_Xamarin.GooglePlayServices.Basement.dll.so => 93
	i64 u0x09d144a7e214d457, ; 26: System.Security.Cryptography => 150
	i64 u0x0a4ff7e2ead194a4, ; 27: lib_SkiaSharp.HarfBuzz.dll.so => 61
	i64 u0x0a953b6893aed54b, ; 28: lib_LiveChartsCore.dll.so => 39
	i64 u0x0abb3e2b271edc45, ; 29: System.Threading.Channels.dll => 156
	i64 u0x0b3b632c3bbee20c, ; 30: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 31: Xamarin.KotlinX.Serialization.Core.Jvm => 98
	i64 u0x0be2e1f8ce4064ed, ; 32: Xamarin.AndroidX.ViewPager => 89
	i64 u0x0c3ca6cc978e2aae, ; 33: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c3dd9438f54f672, ; 34: lib_Xamarin.GooglePlayServices.Maps.dll.so => 94
	i64 u0x0c59ad9fbbd43abe, ; 35: Mono.Android => 169
	i64 u0x0c7790f60165fc06, ; 36: lib_Microsoft.Maui.Essentials.dll.so => 54
	i64 u0x0e14e73a54dda68e, ; 37: lib_System.Net.NameResolution.dll.so => 125
	i64 u0x0ec01b05613190b9, ; 38: SkiaSharp.Views.Android.dll => 62
	i64 u0x0f5e7abaa7cf470a, ; 39: System.Net.HttpListener => 124
	i64 u0x102a31b45304b1da, ; 40: Xamarin.AndroidX.CustomView => 74
	i64 u0x10f6cfcbcf801616, ; 41: System.IO.Compression.Brotli => 117
	i64 u0x11a70d0e1009fb11, ; 42: System.Net.WebSockets.dll => 134
	i64 u0x123639456fb056da, ; 43: System.Reflection.Emit.Lightweight.dll => 141
	i64 u0x125b7f94acb989db, ; 44: Xamarin.AndroidX.RecyclerView.dll => 86
	i64 u0x13a01de0cbc3f06c, ; 45: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 46: lib_Java.Interop.dll.so => 167
	i64 u0x13f1e880c25d96d1, ; 47: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143d8ea60a6a4011, ; 48: Microsoft.Extensions.DependencyInjection.Abstractions => 45
	i64 u0x1497051b917530bd, ; 49: lib_System.Net.WebSockets.dll.so => 134
	i64 u0x17125c9a85b4929f, ; 50: lib_netstandard.dll.so => 165
	i64 u0x17b56e25558a5d36, ; 51: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 52: System.Text.Encodings.Web => 153
	i64 u0x18402a709e357f3b, ; 53: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 98
	i64 u0x18f0ce884e87d89a, ; 54: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x19a4c090f14ebb66, ; 55: System.Security.Claims => 149
	i64 u0x1a91866a319e9259, ; 56: lib_System.Collections.Concurrent.dll.so => 101
	i64 u0x1aac34d1917ba5d3, ; 57: lib_System.dll.so => 164
	i64 u0x1aad60783ffa3e5b, ; 58: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1b062566a8f41ee7, ; 59: LiveChartsCore.SkiaSharpView.Maui => 41
	i64 u0x1c753b5ff15bce1b, ; 60: Mono.Android.Runtime.dll => 168
	i64 u0x1e3d87657e9659bc, ; 61: Xamarin.AndroidX.Navigation.UI => 85
	i64 u0x1e71143913d56c10, ; 62: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 63: Microsoft.Extensions.Options.dll => 48
	i64 u0x1f055d15d807e1b2, ; 64: System.Xml.XmlSerializer => 163
	i64 u0x209375905fcc1bad, ; 65: lib_System.IO.Compression.Brotli.dll.so => 117
	i64 u0x20fab3cf2dfbc8df, ; 66: lib_System.Diagnostics.Process.dll.so => 112
	i64 u0x2174319c0d835bc9, ; 67: System.Runtime => 148
	i64 u0x21cc7e445dcd5469, ; 68: System.Reflection.Emit.ILGeneration => 140
	i64 u0x220fd4f2e7c48170, ; 69: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x2347c268e3e4e536, ; 70: Xamarin.GooglePlayServices.Basement.dll => 93
	i64 u0x237be844f1f812c7, ; 71: System.Threading.Thread.dll => 157
	i64 u0x2407aef2bbe8fadf, ; 72: System.Console => 109
	i64 u0x240abe014b27e7d3, ; 73: Xamarin.AndroidX.Core.dll => 72
	i64 u0x247619fe4413f8bf, ; 74: System.Runtime.Serialization.Primitives.dll => 147
	i64 u0x252073cc3caa62c2, ; 75: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x2662c629b96b0b30, ; 76: lib_Xamarin.Kotlin.StdLib.dll.so => 96
	i64 u0x268c1439f13bcc29, ; 77: lib_Microsoft.Extensions.Primitives.dll.so => 49
	i64 u0x273f3515de5faf0d, ; 78: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 79: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x2759af78ab94d39b, ; 80: System.Net.WebSockets => 134
	i64 u0x27b410442fad6cf1, ; 81: Java.Interop.dll => 167
	i64 u0x2801845a2c71fbfb, ; 82: System.Net.Primitives.dll => 127
	i64 u0x2927d345f3daec35, ; 83: SkiaSharp.dll => 60
	i64 u0x2a128783efe70ba0, ; 84: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a3b095612184159, ; 85: lib_System.Net.NetworkInformation.dll.so => 126
	i64 u0x2a45e6c17076bfbd, ; 86: SkiaSharp.HarfBuzz.dll => 61
	i64 u0x2a6458f5677d9968, ; 87: lib_Mopups.dll.so => 57
	i64 u0x2a6507a5ffabdf28, ; 88: System.Diagnostics.TraceSource.dll => 113
	i64 u0x2ad156c8e1354139, ; 89: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 90: System.Text.RegularExpressions.dll => 155
	i64 u0x2afc1c4f898552ee, ; 91: lib_System.Formats.Asn1.dll.so => 116
	i64 u0x2b148910ed40fbf9, ; 92: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c8bd14bb93a7d82, ; 93: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cc9e1fed6257257, ; 94: lib_System.Reflection.Emit.Lightweight.dll.so => 141
	i64 u0x2cd723e9fe623c7c, ; 95: lib_System.Private.Xml.Linq.dll.so => 138
	i64 u0x2ce03196fe1170d2, ; 96: Microsoft.Maui.Controls.Maps.dll => 51
	i64 u0x2d169d318a968379, ; 97: System.Threading.dll => 158
	i64 u0x2d47774b7d993f59, ; 98: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 99: System.Text.Json.dll => 154
	i64 u0x2e6f1f226821322a, ; 100: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2f02f94df3200fe5, ; 101: System.Diagnostics.Process => 112
	i64 u0x2f2e98e1c89b1aff, ; 102: System.Xml.ReaderWriter => 161
	i64 u0x309ee9eeec09a71e, ; 103: lib_Xamarin.AndroidX.Fragment.dll.so => 76
	i64 u0x30bde19041cd89dd, ; 104: lib_Microsoft.Maui.Maps.dll.so => 56
	i64 u0x31195fef5d8fb552, ; 105: _Microsoft.Android.Resource.Designer.dll => 34
	i64 u0x32243413e774362a, ; 106: Xamarin.AndroidX.CardView.dll => 69
	i64 u0x3235427f8d12dae1, ; 107: lib_System.Drawing.Primitives.dll.so => 114
	i64 u0x326256f7722d4fe5, ; 108: SkiaSharp.Views.Maui.Controls.dll => 63
	i64 u0x329753a17a517811, ; 109: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 110: lib_System.Xml.ReaderWriter.dll.so => 161
	i64 u0x33829542f112d59b, ; 111: System.Collections.Immutable => 102
	i64 u0x33a31443733849fe, ; 112: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x341abc357fbb4ebf, ; 113: lib_System.Net.Sockets.dll.so => 131
	i64 u0x34dfd74fe2afcf37, ; 114: Microsoft.Maui => 53
	i64 u0x34e292762d9615df, ; 115: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 116: Microsoft.Maui.Controls => 50
	i64 u0x3549870798b4cd30, ; 117: lib_Xamarin.AndroidX.ViewPager2.dll.so => 90
	i64 u0x355282fc1c909694, ; 118: Microsoft.Extensions.Configuration => 42
	i64 u0x36b2b50fdf589ae2, ; 119: System.Reflection.Emit.Lightweight => 141
	i64 u0x374ef46b06791af6, ; 120: System.Reflection.Primitives.dll => 142
	i64 u0x380134e03b1e160a, ; 121: System.Collections.Immutable.dll => 102
	i64 u0x385c17636bb6fe6e, ; 122: Xamarin.AndroidX.CustomView.dll => 74
	i64 u0x38869c811d74050e, ; 123: System.Net.NameResolution.dll => 125
	i64 u0x393c226616977fdb, ; 124: lib_Xamarin.AndroidX.ViewPager.dll.so => 89
	i64 u0x395e37c3334cf82a, ; 125: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x39aa39fda111d9d3, ; 126: Newtonsoft.Json => 58
	i64 u0x3b860f9932505633, ; 127: lib_System.Text.Encoding.Extensions.dll.so => 152
	i64 u0x3c385377a4635511, ; 128: Mopups.dll => 57
	i64 u0x3c7c495f58ac5ee9, ; 129: Xamarin.Kotlin.StdLib => 96
	i64 u0x3d46f0b995082740, ; 130: System.Xml.Linq => 160
	i64 u0x3d9c2a242b040a50, ; 131: lib_Xamarin.AndroidX.Core.dll.so => 72
	i64 u0x407a10bb4bf95829, ; 132: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 82
	i64 u0x40c6d9cbfdb8b9f7, ; 133: SkiaSharp.Views.Maui.Core.dll => 64
	i64 u0x40f14d2cf3f60766, ; 134: LiveChartsCore.SkiaSharpView => 40
	i64 u0x41cab042be111c34, ; 135: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 68
	i64 u0x43375950ec7c1b6a, ; 136: netstandard.dll => 165
	i64 u0x434c4e1d9284cdae, ; 137: Mono.Android.dll => 169
	i64 u0x43950f84de7cc79a, ; 138: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x448bd33429269b19, ; 139: Microsoft.CSharp => 100
	i64 u0x4499fa3c8e494654, ; 140: lib_System.Runtime.Serialization.Primitives.dll.so => 147
	i64 u0x4515080865a951a5, ; 141: Xamarin.Kotlin.StdLib.dll => 96
	i64 u0x45c40276a42e283e, ; 142: System.Diagnostics.TraceSource => 113
	i64 u0x46a4213bc97fe5ae, ; 143: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 144: lib_System.Xml.Linq.dll.so => 160
	i64 u0x47daf4e1afbada10, ; 145: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x4980a6419d539b0a, ; 146: lib_AsyncAwaitBestPractices.dll.so => 35
	i64 u0x49e952f19a4e2022, ; 147: System.ObjectModel => 136
	i64 u0x4a5667b2462a664b, ; 148: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 85
	i64 u0x4b7b6532ded934b7, ; 149: System.Text.Json => 154
	i64 u0x4bf547f87e5016a8, ; 150: lib_SkiaSharp.Views.Android.dll.so => 62
	i64 u0x4c9caee94c082049, ; 151: Xamarin.GooglePlayServices.Maps => 94
	i64 u0x4cc5f15266470798, ; 152: lib_Xamarin.AndroidX.Loader.dll.so => 81
	i64 u0x4cf6f67dc77aacd2, ; 153: System.Net.NetworkInformation.dll => 126
	i64 u0x4d3183dd245425d4, ; 154: System.Net.WebSockets.Client.dll => 133
	i64 u0x4d479f968a05e504, ; 155: System.Linq.Expressions.dll => 120
	i64 u0x4d55a010ffc4faff, ; 156: System.Private.Xml => 139
	i64 u0x4d95fccc1f67c7ca, ; 157: System.Runtime.Loader.dll => 144
	i64 u0x4dcf44c3c9b076a2, ; 158: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 159: Xamarin.AndroidX.Loader.dll => 81
	i64 u0x4e32f00cb0937401, ; 160: Mono.Android.Runtime => 168
	i64 u0x4ebd0c4b82c5eefc, ; 161: lib_System.Threading.Channels.dll.so => 156
	i64 u0x4f21ee6ef9eb527e, ; 162: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x5037f0be3c28c7a3, ; 163: lib_Microsoft.Maui.Controls.dll.so => 50
	i64 u0x5131bbe80989093f, ; 164: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 79
	i64 u0x51bb8a2afe774e32, ; 165: System.Drawing => 115
	i64 u0x526ce79eb8e90527, ; 166: lib_System.Net.Primitives.dll.so => 127
	i64 u0x52829f00b4467c38, ; 167: lib_System.Data.Common.dll.so => 110
	i64 u0x529ffe06f39ab8db, ; 168: Xamarin.AndroidX.Core => 72
	i64 u0x52ff996554dbf352, ; 169: Microsoft.Maui.Graphics => 55
	i64 u0x535f7e40e8fef8af, ; 170: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53a96d5c86c9e194, ; 171: System.Net.NetworkInformation => 126
	i64 u0x53c3014b9437e684, ; 172: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x5435e6f049e9bc37, ; 173: System.Security.Claims.dll => 149
	i64 u0x54795225dd1587af, ; 174: lib_System.Runtime.dll.so => 148
	i64 u0x556e8b63b660ab8b, ; 175: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 77
	i64 u0x5588627c9a108ec9, ; 176: System.Collections.Specialized => 104
	i64 u0x561449e1215a61e4, ; 177: lib_SkiaSharp.Views.Maui.Core.dll.so => 64
	i64 u0x571c5cfbec5ae8e2, ; 178: System.Private.Uri => 137
	i64 u0x579a06fed6eec900, ; 179: System.Private.CoreLib.dll => 166
	i64 u0x57c542c14049b66d, ; 180: System.Diagnostics.DiagnosticSource => 111
	i64 u0x58601b2dda4a27b9, ; 181: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 182: Microsoft.Extensions.DependencyInjection.dll => 44
	i64 u0x58b764eaa003a680, ; 183: LiveChartsCore.SkiaSharpView.Maui.dll => 41
	i64 u0x595a356d23e8da9a, ; 184: lib_Microsoft.CSharp.dll.so => 100
	i64 u0x5a89a886ae30258d, ; 185: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 71
	i64 u0x5a8f6699f4a1caa9, ; 186: lib_System.Threading.dll.so => 158
	i64 u0x5ae9cd33b15841bf, ; 187: System.ComponentModel => 108
	i64 u0x5b5ba1327561f926, ; 188: lib_SkiaSharp.Views.Maui.Controls.dll.so => 63
	i64 u0x5b5f0e240a06a2a2, ; 189: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5b755276902c8414, ; 190: Xamarin.GooglePlayServices.Base => 92
	i64 u0x5c393624b8176517, ; 191: lib_Microsoft.Extensions.Logging.dll.so => 46
	i64 u0x5d0a4a29b02d9d3c, ; 192: System.Net.WebHeaderCollection.dll => 132
	i64 u0x5db0cbbd1028510e, ; 193: lib_System.Runtime.InteropServices.dll.so => 143
	i64 u0x5db30905d3e5013b, ; 194: Xamarin.AndroidX.Collection.Jvm.dll => 70
	i64 u0x5e467bc8f09ad026, ; 195: System.Collections.Specialized.dll => 104
	i64 u0x5ea92fdb19ec8c4c, ; 196: System.Text.Encodings.Web.dll => 153
	i64 u0x5eb8046dd40e9ac3, ; 197: System.ComponentModel.Primitives => 106
	i64 u0x5eee1376d94c7f5e, ; 198: System.Net.HttpListener.dll => 124
	i64 u0x5f36ccf5c6a57e24, ; 199: System.Xml.ReaderWriter.dll => 161
	i64 u0x5f4294b9b63cb842, ; 200: System.Data.Common => 110
	i64 u0x5f9a2d823f664957, ; 201: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x609f4b7b63d802d4, ; 202: lib_Microsoft.Extensions.DependencyInjection.dll.so => 44
	i64 u0x60cd4e33d7e60134, ; 203: Xamarin.KotlinX.Coroutines.Core.Jvm => 97
	i64 u0x60f62d786afcf130, ; 204: System.Memory => 122
	i64 u0x61be8d1299194243, ; 205: Microsoft.Maui.Controls.Xaml => 52
	i64 u0x61d2cba29557038f, ; 206: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 207: lib_System.Runtime.Loader.dll.so => 144
	i64 u0x622eef6f9e59068d, ; 208: System.Private.CoreLib => 166
	i64 u0x62ecc683af4df22b, ; 209: StreetLightApp => 99
	i64 u0x63f1f6883c1e23c2, ; 210: lib_System.Collections.Immutable.dll.so => 102
	i64 u0x6400f68068c1e9f1, ; 211: Xamarin.Google.Android.Material.dll => 91
	i64 u0x658f524e4aba7dad, ; 212: CommunityToolkit.Maui.dll => 36
	i64 u0x65ecac39144dd3cc, ; 213: Microsoft.Maui.Controls.dll => 50
	i64 u0x65ece51227bfa724, ; 214: lib_System.Runtime.Numerics.dll.so => 145
	i64 u0x666e27ef6dad9ee1, ; 215: RestSharp => 59
	i64 u0x6692e924eade1b29, ; 216: lib_System.Console.dll.so => 109
	i64 u0x66a4e5c6a3fb0bae, ; 217: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 79
	i64 u0x66d13304ce1a3efa, ; 218: Xamarin.AndroidX.CursorAdapter => 73
	i64 u0x6833770b38d7bb8e, ; 219: LiveChartsCore.SkiaSharpView.dll => 40
	i64 u0x68558ec653afa616, ; 220: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 221: System.Drawing.Primitives.dll => 114
	i64 u0x68fbbbe2eb455198, ; 222: System.Formats.Asn1 => 116
	i64 u0x69063fc0ba8e6bdd, ; 223: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x69fbb0da5a16621d, ; 224: RestSharp.dll => 59
	i64 u0x6a4d7577b2317255, ; 225: System.Runtime.InteropServices.dll => 143
	i64 u0x6ace3b74b15ee4a4, ; 226: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6d12bfaa99c72b1f, ; 227: lib_Microsoft.Maui.Graphics.dll.so => 55
	i64 u0x6d79993361e10ef2, ; 228: Microsoft.Extensions.Primitives => 49
	i64 u0x6d86d56b84c8eb71, ; 229: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 73
	i64 u0x6d9bea6b3e895cf7, ; 230: Microsoft.Extensions.Primitives.dll => 49
	i64 u0x6e25a02c3833319a, ; 231: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 83
	i64 u0x6fd2265da78b93a4, ; 232: lib_Microsoft.Maui.dll.so => 53
	i64 u0x6fdfc7de82c33008, ; 233: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x70e99f48c05cb921, ; 234: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 235: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x71a495ea3761dde8, ; 236: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 237: System.ComponentModel.Primitives.dll => 106
	i64 u0x72b1fb4109e08d7b, ; 238: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x73e4ce94e2eb6ffc, ; 239: lib_System.Memory.dll.so => 122
	i64 u0x755a91767330b3d4, ; 240: lib_Microsoft.Extensions.Configuration.dll.so => 42
	i64 u0x75f5d8ba43e33e01, ; 241: Mopups => 57
	i64 u0x76012e7334db86e5, ; 242: lib_Xamarin.AndroidX.SavedState.dll.so => 87
	i64 u0x76ca07b878f44da0, ; 243: System.Runtime.Numerics.dll => 145
	i64 u0x780bc73597a503a9, ; 244: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 245: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a45e51311409b6, ; 246: Xamarin.AndroidX.Fragment.dll => 76
	i64 u0x7adb8da2ac89b647, ; 247: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7bef86a4335c4870, ; 248: System.ComponentModel.TypeConverter => 107
	i64 u0x7c0820144cd34d6a, ; 249: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 250: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7cb95ad2a929d044, ; 251: Xamarin.GooglePlayServices.Basement => 93
	i64 u0x7cc637f941f716d0, ; 252: CommunityToolkit.Maui.Core => 37
	i64 u0x7d649b75d580bb42, ; 253: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 254: System.Numerics.Vectors => 135
	i64 u0x7dfc3d6d9d8d7b70, ; 255: System.Collections => 105
	i64 u0x7e302e110e1e1346, ; 256: lib_System.Security.Claims.dll.so => 149
	i64 u0x7e946809d6008ef2, ; 257: lib_System.ObjectModel.dll.so => 136
	i64 u0x7eb4f0dc47488736, ; 258: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 95
	i64 u0x7ecc13347c8fd849, ; 259: lib_System.ComponentModel.dll.so => 108
	i64 u0x7f00ddd9b9ca5a13, ; 260: Xamarin.AndroidX.ViewPager.dll => 89
	i64 u0x7f9351cd44b1273f, ; 261: Microsoft.Extensions.Configuration.Abstractions => 43
	i64 u0x7fbd557c99b3ce6f, ; 262: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 78
	i64 u0x812c069d5cdecc17, ; 263: System.dll => 164
	i64 u0x81ab745f6c0f5ce6, ; 264: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x8277f2be6b5ce05f, ; 265: Xamarin.AndroidX.AppCompat => 67
	i64 u0x828f06563b30bc50, ; 266: lib_Xamarin.AndroidX.CardView.dll.so => 69
	i64 u0x82df8f5532a10c59, ; 267: lib_System.Drawing.dll.so => 115
	i64 u0x82f6403342e12049, ; 268: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83c14ba66c8e2b8c, ; 269: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x84f9060cc4a93c8f, ; 270: lib_SkiaSharp.dll.so => 60
	i64 u0x86a909228dc7657b, ; 271: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 272: Microsoft.Extensions.Configuration.dll => 42
	i64 u0x87c69b87d9283884, ; 273: lib_System.Threading.Thread.dll.so => 157
	i64 u0x87f6569b25707834, ; 274: System.IO.Compression.Brotli.dll => 117
	i64 u0x8808a9d7c53dc4c0, ; 275: lib_HarfBuzzSharp.dll.so => 38
	i64 u0x8842b3a5d2d3fb36, ; 276: Microsoft.Maui.Essentials => 54
	i64 u0x88bda98e0cffb7a9, ; 277: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 97
	i64 u0x8930322c7bd8f768, ; 278: netstandard => 165
	i64 u0x897a606c9e39c75f, ; 279: lib_System.ComponentModel.Primitives.dll.so => 106
	i64 u0x89b982005ca4240b, ; 280: LiveChartsCore.dll => 39
	i64 u0x8ad229ea26432ee2, ; 281: Xamarin.AndroidX.Loader => 81
	i64 u0x8b4ff5d0fdd5faa1, ; 282: lib_System.Diagnostics.DiagnosticSource.dll.so => 111
	i64 u0x8b541d476eb3774c, ; 283: System.Security.Principal.Windows => 151
	i64 u0x8b8d01333a96d0b5, ; 284: System.Diagnostics.Process.dll => 112
	i64 u0x8b9ceca7acae3451, ; 285: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8ca24177b75ede73, ; 286: WatsonWebsocket.dll => 65
	i64 u0x8cdfdb4ce85fb925, ; 287: lib_System.Security.Principal.Windows.dll.so => 151
	i64 u0x8d0f420977c2c1c7, ; 288: Xamarin.AndroidX.CursorAdapter.dll => 73
	i64 u0x8d7b8ab4b3310ead, ; 289: System.Threading => 158
	i64 u0x8da188285aadfe8e, ; 290: System.Collections.Concurrent => 101
	i64 u0x8ec6e06a61c1baeb, ; 291: lib_Newtonsoft.Json.dll.so => 58
	i64 u0x8ed807bfe9858dfc, ; 292: Xamarin.AndroidX.Navigation.Common => 82
	i64 u0x8ee08b8194a30f48, ; 293: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 294: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8efbc0801a122264, ; 295: Xamarin.GooglePlayServices.Tasks.dll => 95
	i64 u0x8f32c6f611f6ffab, ; 296: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 297: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x90263f8448b8f572, ; 298: lib_System.Diagnostics.TraceSource.dll.so => 113
	i64 u0x903101b46fb73a04, ; 299: _Microsoft.Android.Resource.Designer => 34
	i64 u0x90393bd4865292f3, ; 300: lib_System.IO.Compression.dll.so => 118
	i64 u0x90634f86c5ebe2b5, ; 301: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 79
	i64 u0x907b636704ad79ef, ; 302: lib_Microsoft.Maui.Controls.Xaml.dll.so => 52
	i64 u0x91418dc638b29e68, ; 303: lib_Xamarin.AndroidX.CustomView.dll.so => 74
	i64 u0x9157bd523cd7ed36, ; 304: lib_System.Text.Json.dll.so => 154
	i64 u0x91a74f07b30d37e2, ; 305: System.Linq.dll => 121
	i64 u0x91fa41a87223399f, ; 306: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x93cfa73ab28d6e35, ; 307: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 308: System.IO.Compression.dll => 118
	i64 u0x967fc325e09bfa8c, ; 309: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x9732d8dbddea3d9a, ; 310: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 311: Microsoft.Maui.Graphics.dll => 55
	i64 u0x979ab54025cc1c7f, ; 312: lib_Xamarin.GooglePlayServices.Base.dll.so => 92
	i64 u0x97b8c771ea3e4220, ; 313: System.ComponentModel.dll => 108
	i64 u0x97e144c9d3c6976e, ; 314: System.Collections.Concurrent.dll => 101
	i64 u0x991d510397f92d9d, ; 315: System.Linq.Expressions => 120
	i64 u0x99a00ca5270c6878, ; 316: Xamarin.AndroidX.Navigation.Runtime => 84
	i64 u0x99cdc6d1f2d3a72f, ; 317: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9d185d226bf3df50, ; 318: lib_RestSharp.dll.so => 59
	i64 u0x9d5dbcf5a48583fe, ; 319: lib_Xamarin.AndroidX.Activity.dll.so => 66
	i64 u0x9d74dee1a7725f34, ; 320: Microsoft.Extensions.Configuration.Abstractions.dll => 43
	i64 u0x9e4534b6adaf6e84, ; 321: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 322: Xamarin.AndroidX.Navigation.Common.dll => 82
	i64 u0x9ef542cf1f78c506, ; 323: Xamarin.AndroidX.Lifecycle.LiveData.Core => 78
	i64 u0xa0d8259f4cc284ec, ; 324: lib_System.Security.Cryptography.dll.so => 150
	i64 u0xa1440773ee9d341e, ; 325: Xamarin.Google.Android.Material => 91
	i64 u0xa1b9d7c27f47219f, ; 326: Xamarin.AndroidX.Navigation.UI.dll => 85
	i64 u0xa2572680829d2c7c, ; 327: System.IO.Pipelines.dll => 119
	i64 u0xa2beee74530fc01c, ; 328: SkiaSharp.Views.Android => 62
	i64 u0xa46aa1eaa214539b, ; 329: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa4edc8f2ceae241a, ; 330: System.Data.Common.dll => 110
	i64 u0xa5494f40f128ce6a, ; 331: System.Runtime.Serialization.Formatters.dll => 146
	i64 u0xa5e599d1e0524750, ; 332: System.Numerics.Vectors.dll => 135
	i64 u0xa5f1ba49b85dd355, ; 333: System.Security.Cryptography.dll => 150
	i64 u0xa61975a5a37873ea, ; 334: lib_System.Xml.XmlSerializer.dll.so => 163
	i64 u0xa67dbee13e1df9ca, ; 335: Xamarin.AndroidX.SavedState.dll => 87
	i64 u0xa68a420042bb9b1f, ; 336: Xamarin.AndroidX.DrawerLayout.dll => 75
	i64 u0xa78ce3745383236a, ; 337: Xamarin.AndroidX.Lifecycle.Common.Jvm => 77
	i64 u0xa7c31b56b4dc7b33, ; 338: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa843f6095f0d247d, ; 339: Xamarin.GooglePlayServices.Base.dll => 92
	i64 u0xa964304b5631e28a, ; 340: CommunityToolkit.Maui.Core.dll => 37
	i64 u0xaa2219c8e3449ff5, ; 341: Microsoft.Extensions.Logging.Abstractions => 47
	i64 u0xaa443ac34067eeef, ; 342: System.Private.Xml.dll => 139
	i64 u0xaa52de307ef5d1dd, ; 343: System.Net.Http => 123
	i64 u0xaaaf86367285a918, ; 344: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 45
	i64 u0xaaf84bb3f052a265, ; 345: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab61dc30d4483813, ; 346: AsyncAwaitBestPractices => 35
	i64 u0xab9c1b2687d86b0b, ; 347: lib_System.Linq.Expressions.dll.so => 120
	i64 u0xac2af3fa195a15ce, ; 348: System.Runtime.Numerics => 145
	i64 u0xac5376a2a538dc10, ; 349: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 78
	i64 u0xac79c7e46047ad98, ; 350: System.Security.Principal.Windows.dll => 151
	i64 u0xac98d31068e24591, ; 351: System.Xml.XDocument => 162
	i64 u0xacadd3cbe26c6a9b, ; 352: lib_StreetLightApp.dll.so => 99
	i64 u0xacd46e002c3ccb97, ; 353: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xacf42eea7ef9cd12, ; 354: System.Threading.Channels => 156
	i64 u0xad89c07347f1bad6, ; 355: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 356: System.Web.HttpUtility => 159
	i64 u0xadc90ab061a9e6e4, ; 357: System.ComponentModel.TypeConverter.dll => 107
	i64 u0xadf4cf30debbeb9a, ; 358: System.Net.ServicePoint.dll => 130
	i64 u0xadf511667bef3595, ; 359: System.Net.Security => 129
	i64 u0xae282bcd03739de7, ; 360: Java.Interop => 167
	i64 u0xae53579c90db1107, ; 361: System.ObjectModel.dll => 136
	i64 u0xafe29f45095518e7, ; 362: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 80
	i64 u0xb05cc42cd94c6d9d, ; 363: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb220631954820169, ; 364: System.Text.RegularExpressions => 155
	i64 u0xb2a3f67f3bf29fce, ; 365: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb3f0a0fcda8d3ebc, ; 366: Xamarin.AndroidX.CardView => 69
	i64 u0xb46be1aa6d4fff93, ; 367: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 368: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 369: System.IO.Pipelines => 119
	i64 u0xb5c7fcdafbc67ee4, ; 370: Microsoft.Extensions.Logging.Abstractions.dll => 47
	i64 u0xb7212c4683a94afe, ; 371: System.Drawing.Primitives => 114
	i64 u0xb7b7753d1f319409, ; 372: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 373: lib_System.Private.CoreLib.dll.so => 166
	i64 u0xb8c60af47c08d4da, ; 374: System.Net.ServicePoint => 130
	i64 u0xb9185c33a1643eed, ; 375: Microsoft.CSharp.dll => 100
	i64 u0xb9b19a3eb1924681, ; 376: lib_Microsoft.Maui.Controls.Maps.dll.so => 51
	i64 u0xb9f64d3b230def68, ; 377: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 378: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba4670aa94a2b3c6, ; 379: lib_System.Xml.XDocument.dll.so => 162
	i64 u0xba48785529705af9, ; 380: System.Collections.dll => 105
	i64 u0xbb65706fde942ce3, ; 381: System.Net.Sockets => 131
	i64 u0xbb90881f448f3119, ; 382: lib_WatsonWebsocket.dll.so => 65
	i64 u0xbbd180354b67271a, ; 383: System.Runtime.Serialization.Formatters => 146
	i64 u0xbd0e2c0d55246576, ; 384: System.Net.Http.dll => 123
	i64 u0xbd3fbd85b9e1cb29, ; 385: lib_System.Net.HttpListener.dll.so => 124
	i64 u0xbd437a2cdb333d0d, ; 386: Xamarin.AndroidX.ViewPager2 => 90
	i64 u0xbee38d4a88835966, ; 387: Xamarin.AndroidX.AppCompat.AppCompatResources => 68
	i64 u0xc040a4ab55817f58, ; 388: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 389: System.Console.dll => 109
	i64 u0xc12b8b3afa48329c, ; 390: lib_System.Linq.dll.so => 121
	i64 u0xc1ff9ae3cdb6e1e6, ; 391: Xamarin.AndroidX.Activity.dll => 66
	i64 u0xc28c50f32f81cc73, ; 392: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2bcfec99f69365e, ; 393: Xamarin.AndroidX.ViewPager2.dll => 90
	i64 u0xc421b61fd853169d, ; 394: lib_System.Net.WebSockets.Client.dll.so => 133
	i64 u0xc4d3858ed4d08512, ; 395: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 80
	i64 u0xc50fded0ded1418c, ; 396: lib_System.ComponentModel.TypeConverter.dll.so => 107
	i64 u0xc519125d6bc8fb11, ; 397: lib_System.Net.Requests.dll.so => 128
	i64 u0xc5293b19e4dc230e, ; 398: Xamarin.AndroidX.Navigation.Fragment => 83
	i64 u0xc5325b2fcb37446f, ; 399: lib_System.Private.Xml.dll.so => 139
	i64 u0xc5a0f4b95a699af7, ; 400: lib_System.Private.Uri.dll.so => 137
	i64 u0xc64f6952cef5d09f, ; 401: Microsoft.Maui.Maps.dll => 56
	i64 u0xc68e480c8069e1f7, ; 402: Microsoft.Maui.Maps => 56
	i64 u0xc7c01e7d7c93a110, ; 403: System.Text.Encoding.Extensions.dll => 152
	i64 u0xc7ce851898a4548e, ; 404: lib_System.Web.HttpUtility.dll.so => 159
	i64 u0xc7ed073e3cbec16d, ; 405: WatsonWebsocket => 65
	i64 u0xc858a28d9ee5a6c5, ; 406: lib_System.Collections.Specialized.dll.so => 104
	i64 u0xc9e54b32fc19baf3, ; 407: lib_CommunityToolkit.Maui.dll.so => 36
	i64 u0xca3a723e7342c5b6, ; 408: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 409: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 410: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcbd4fdd9cef4a294, ; 411: lib__Microsoft.Android.Resource.Designer.dll.so => 34
	i64 u0xcc2876b32ef2794c, ; 412: lib_System.Text.RegularExpressions.dll.so => 155
	i64 u0xcc5c3bb714c4561e, ; 413: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 97
	i64 u0xcc76886e09b88260, ; 414: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 98
	i64 u0xccf25c4b634ccd3a, ; 415: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 416: System.Net.Requests => 128
	i64 u0xcdd0c48b6937b21c, ; 417: Xamarin.AndroidX.SwipeRefreshLayout => 88
	i64 u0xcf23d8093f3ceadf, ; 418: System.Diagnostics.DiagnosticSource.dll => 111
	i64 u0xcf8fc898f98b0d34, ; 419: System.Private.Xml.Linq => 138
	i64 u0xcfb21487d9cb358b, ; 420: Xamarin.GooglePlayServices.Maps.dll => 94
	i64 u0xd1194e1d8a8de83c, ; 421: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 77
	i64 u0xd333d0af9e423810, ; 422: System.Runtime.InteropServices => 143
	i64 u0xd3426d966bb704f5, ; 423: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 68
	i64 u0xd3651b6fc3125825, ; 424: System.Private.Uri.dll => 137
	i64 u0xd373685349b1fe8b, ; 425: Microsoft.Extensions.Logging.dll => 46
	i64 u0xd3e4c8d6a2d5d470, ; 426: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd4645626dffec99d, ; 427: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 45
	i64 u0xd5507e11a2b2839f, ; 428: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 80
	i64 u0xd6694f8359737e4e, ; 429: Xamarin.AndroidX.SavedState => 87
	i64 u0xd6d21782156bc35b, ; 430: Xamarin.AndroidX.SwipeRefreshLayout.dll => 88
	i64 u0xd72329819cbbbc44, ; 431: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 43
	i64 u0xd72c760af136e863, ; 432: System.Xml.XmlSerializer.dll => 163
	i64 u0xd780f1a3e2e12e16, ; 433: lib_LiveChartsCore.SkiaSharpView.dll.so => 40
	i64 u0xd7b3764ada9d341d, ; 434: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 47
	i64 u0xda1dfa4c534a9251, ; 435: Microsoft.Extensions.DependencyInjection => 44
	i64 u0xdad05a11827959a3, ; 436: System.Collections.NonGeneric.dll => 103
	i64 u0xdb5383ab5865c007, ; 437: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdb58816721c02a59, ; 438: lib_System.Reflection.Emit.ILGeneration.dll.so => 140
	i64 u0xdb8f858873e2186b, ; 439: SkiaSharp.Views.Maui.Controls => 63
	i64 u0xdbeda89f832aa805, ; 440: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf9607a441b4505, ; 441: System.Linq => 121
	i64 u0xdce2c53525640bf3, ; 442: Microsoft.Extensions.Logging => 46
	i64 u0xdd2b722d78ef5f43, ; 443: System.Runtime.dll => 148
	i64 u0xdd67031857c72f96, ; 444: lib_System.Text.Encodings.Web.dll.so => 153
	i64 u0xdde30e6b77aa6f6c, ; 445: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xddf8227337aa0462, ; 446: SkiaSharp.HarfBuzz => 61
	i64 u0xde110ae80fa7c2e2, ; 447: System.Xml.XDocument.dll => 162
	i64 u0xde8769ebda7d8647, ; 448: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xe0142572c095a480, ; 449: Xamarin.AndroidX.AppCompat.dll => 67
	i64 u0xe02f89350ec78051, ; 450: Xamarin.AndroidX.CoordinatorLayout.dll => 71
	i64 u0xe192a588d4410686, ; 451: lib_System.IO.Pipelines.dll.so => 119
	i64 u0xe1a08bd3fa539e0d, ; 452: System.Runtime.Loader => 144
	i64 u0xe1b52f9f816c70ef, ; 453: System.Private.Xml.Linq.dll => 138
	i64 u0xe1ecfdb7fff86067, ; 454: System.Net.Security.dll => 129
	i64 u0xe2420585aeceb728, ; 455: System.Net.Requests.dll => 128
	i64 u0xe29b73bc11392966, ; 456: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe3811d68d4fe8463, ; 457: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe494f7ced4ecd10a, ; 458: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 459: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 460: System.Runtime.Serialization.Primitives => 147
	i64 u0xe5434e8a119ceb69, ; 461: lib_Mono.Android.dll.so => 169
	i64 u0xe89a2a9ef110899b, ; 462: System.Drawing.dll => 115
	i64 u0xedc4817167106c23, ; 463: System.Net.Sockets.dll => 131
	i64 u0xedc632067fb20ff3, ; 464: System.Memory.dll => 122
	i64 u0xedc8e4ca71a02a8b, ; 465: Xamarin.AndroidX.Navigation.Runtime.dll => 84
	i64 u0xee27c952ed6d058b, ; 466: Microsoft.Maui.Controls.Maps => 51
	i64 u0xeeb7ebb80150501b, ; 467: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 70
	i64 u0xef72742e1bcca27a, ; 468: Microsoft.Maui.Essentials.dll => 54
	i64 u0xefec0b7fdc57ec42, ; 469: Xamarin.AndroidX.Activity => 66
	i64 u0xf00c29406ea45e19, ; 470: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf09e47b6ae914f6e, ; 471: System.Net.NameResolution => 125
	i64 u0xf0bb49dadd3a1fe1, ; 472: lib_System.Net.ServicePoint.dll.so => 130
	i64 u0xf0de2537ee19c6ca, ; 473: lib_System.Net.WebHeaderCollection.dll.so => 132
	i64 u0xf11b621fc87b983f, ; 474: Microsoft.Maui.Controls.Xaml.dll => 52
	i64 u0xf1c4b4005493d871, ; 475: System.Formats.Asn1.dll => 116
	i64 u0xf238bd79489d3a96, ; 476: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 477: lib_Xamarin.Google.Android.Material.dll.so => 91
	i64 u0xf397148270133fa9, ; 478: lib_LiveChartsCore.SkiaSharpView.Maui.dll.so => 41
	i64 u0xf3ddfe05336abf29, ; 479: System => 164
	i64 u0xf408654b2a135055, ; 480: System.Reflection.Emit.ILGeneration.dll => 140
	i64 u0xf4727d423e5d26f3, ; 481: SkiaSharp => 60
	i64 u0xf4c1dd70a5496a17, ; 482: System.IO.Compression => 118
	i64 u0xf5fc7602fe27b333, ; 483: System.Net.WebHeaderCollection => 132
	i64 u0xf6077741019d7428, ; 484: Xamarin.AndroidX.CoordinatorLayout => 71
	i64 u0xf77b20923f07c667, ; 485: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 486: lib_System.Numerics.Vectors.dll.so => 135
	i64 u0xf7e74930e0e3d214, ; 487: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf7fa0bf77fe677cc, ; 488: Newtonsoft.Json.dll => 58
	i64 u0xf84773b5c81e3cef, ; 489: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf8b77539b362d3ba, ; 490: lib_System.Reflection.Primitives.dll.so => 142
	i64 u0xf8e045dc345b2ea3, ; 491: lib_Xamarin.AndroidX.RecyclerView.dll.so => 86
	i64 u0xf915dc29808193a1, ; 492: System.Web.HttpUtility.dll => 159
	i64 u0xf96c777a2a0686f4, ; 493: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9eec5bb3a6aedc6, ; 494: Microsoft.Extensions.Options => 48
	i64 u0xfa3f278f288b0e84, ; 495: lib_System.Net.Security.dll.so => 129
	i64 u0xfa5ed7226d978949, ; 496: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 497: System.Threading.Thread => 157
	i64 u0xfa99d44ebf9bea5b, ; 498: SkiaSharp.Views.Maui.Core => 64
	i64 u0xfb2eb63cfdeda9a5, ; 499: StreetLightApp.dll => 99
	i64 u0xfbf0a31c9fc34bc4, ; 500: lib_System.Net.Http.dll.so => 123
	i64 u0xfc6b7527cc280b3f, ; 501: lib_System.Runtime.Serialization.Formatters.dll.so => 146
	i64 u0xfc719aec26adf9d9, ; 502: Xamarin.AndroidX.Navigation.Fragment.dll => 83
	i64 u0xfd22f00870e40ae0, ; 503: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 75
	i64 u0xfd536c702f64dc47, ; 504: System.Text.Encoding.Extensions => 152
	i64 u0xfd583f7657b6a1cb, ; 505: Xamarin.AndroidX.Fragment => 76
	i64 u0xfda36abccf05cf5c, ; 506: System.Net.WebSockets.Client => 133
	i64 u0xfdbe4710aa9beeff, ; 507: CommunityToolkit.Maui => 36
	i64 u0xfeae9952cf03b8cb, ; 508: tr/Microsoft.Maui.Controls.resources => 28
	i64 u0xfeca84fe7f34860b ; 509: HarfBuzzSharp.dll => 38
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [510 x i32] [
	i32 88, i32 35, i32 84, i32 37, i32 168, i32 67, i32 24, i32 2,
	i32 30, i32 127, i32 95, i32 86, i32 105, i32 53, i32 38, i32 31,
	i32 160, i32 70, i32 39, i32 24, i32 103, i32 142, i32 75, i32 48,
	i32 103, i32 93, i32 150, i32 61, i32 39, i32 156, i32 25, i32 98,
	i32 89, i32 21, i32 94, i32 169, i32 54, i32 125, i32 62, i32 124,
	i32 74, i32 117, i32 134, i32 141, i32 86, i32 8, i32 167, i32 9,
	i32 45, i32 134, i32 165, i32 12, i32 153, i32 98, i32 18, i32 149,
	i32 101, i32 164, i32 27, i32 41, i32 168, i32 85, i32 16, i32 48,
	i32 163, i32 117, i32 112, i32 148, i32 140, i32 27, i32 93, i32 157,
	i32 109, i32 72, i32 147, i32 8, i32 96, i32 49, i32 13, i32 11,
	i32 134, i32 167, i32 127, i32 60, i32 29, i32 126, i32 61, i32 57,
	i32 113, i32 7, i32 155, i32 116, i32 33, i32 20, i32 141, i32 138,
	i32 51, i32 158, i32 26, i32 154, i32 5, i32 112, i32 161, i32 76,
	i32 56, i32 34, i32 69, i32 114, i32 63, i32 8, i32 161, i32 102,
	i32 6, i32 131, i32 53, i32 2, i32 50, i32 90, i32 42, i32 141,
	i32 142, i32 102, i32 74, i32 125, i32 89, i32 1, i32 58, i32 152,
	i32 57, i32 96, i32 160, i32 72, i32 82, i32 64, i32 40, i32 68,
	i32 165, i32 169, i32 20, i32 100, i32 147, i32 96, i32 113, i32 24,
	i32 160, i32 22, i32 35, i32 136, i32 85, i32 154, i32 62, i32 94,
	i32 81, i32 126, i32 133, i32 120, i32 139, i32 144, i32 14, i32 81,
	i32 168, i32 156, i32 1, i32 50, i32 79, i32 115, i32 127, i32 110,
	i32 72, i32 55, i32 25, i32 126, i32 31, i32 149, i32 148, i32 77,
	i32 104, i32 64, i32 137, i32 166, i32 111, i32 15, i32 44, i32 41,
	i32 100, i32 71, i32 158, i32 108, i32 63, i32 3, i32 92, i32 46,
	i32 132, i32 143, i32 70, i32 104, i32 153, i32 106, i32 124, i32 161,
	i32 110, i32 5, i32 44, i32 97, i32 122, i32 52, i32 4, i32 144,
	i32 166, i32 99, i32 102, i32 91, i32 36, i32 50, i32 145, i32 59,
	i32 109, i32 79, i32 73, i32 40, i32 3, i32 114, i32 116, i32 9,
	i32 59, i32 143, i32 18, i32 55, i32 49, i32 73, i32 49, i32 83,
	i32 53, i32 2, i32 28, i32 18, i32 14, i32 106, i32 11, i32 122,
	i32 42, i32 57, i32 87, i32 145, i32 17, i32 27, i32 76, i32 7,
	i32 107, i32 25, i32 4, i32 93, i32 37, i32 17, i32 135, i32 105,
	i32 149, i32 136, i32 95, i32 108, i32 89, i32 43, i32 78, i32 164,
	i32 33, i32 67, i32 69, i32 115, i32 29, i32 32, i32 60, i32 33,
	i32 42, i32 157, i32 117, i32 38, i32 54, i32 97, i32 165, i32 106,
	i32 39, i32 81, i32 111, i32 151, i32 112, i32 9, i32 65, i32 151,
	i32 73, i32 158, i32 101, i32 58, i32 82, i32 10, i32 23, i32 95,
	i32 22, i32 21, i32 113, i32 34, i32 118, i32 79, i32 52, i32 74,
	i32 154, i32 121, i32 1, i32 17, i32 118, i32 6, i32 13, i32 55,
	i32 92, i32 108, i32 101, i32 120, i32 84, i32 16, i32 59, i32 66,
	i32 43, i32 19, i32 82, i32 78, i32 150, i32 91, i32 85, i32 119,
	i32 62, i32 16, i32 110, i32 146, i32 135, i32 150, i32 163, i32 87,
	i32 75, i32 77, i32 12, i32 92, i32 37, i32 47, i32 139, i32 123,
	i32 45, i32 5, i32 35, i32 120, i32 145, i32 78, i32 151, i32 162,
	i32 99, i32 23, i32 156, i32 19, i32 159, i32 107, i32 130, i32 129,
	i32 167, i32 136, i32 80, i32 26, i32 155, i32 3, i32 69, i32 10,
	i32 0, i32 119, i32 47, i32 114, i32 26, i32 166, i32 130, i32 100,
	i32 51, i32 22, i32 15, i32 162, i32 105, i32 131, i32 65, i32 146,
	i32 123, i32 124, i32 90, i32 68, i32 0, i32 109, i32 121, i32 66,
	i32 15, i32 90, i32 133, i32 80, i32 107, i32 128, i32 83, i32 139,
	i32 137, i32 56, i32 56, i32 152, i32 159, i32 65, i32 104, i32 36,
	i32 28, i32 20, i32 23, i32 34, i32 155, i32 97, i32 98, i32 32,
	i32 128, i32 88, i32 111, i32 138, i32 94, i32 77, i32 143, i32 68,
	i32 137, i32 46, i32 14, i32 45, i32 80, i32 87, i32 88, i32 43,
	i32 163, i32 40, i32 47, i32 44, i32 103, i32 30, i32 140, i32 63,
	i32 30, i32 121, i32 46, i32 148, i32 153, i32 32, i32 61, i32 162,
	i32 11, i32 67, i32 71, i32 119, i32 144, i32 138, i32 129, i32 128,
	i32 13, i32 21, i32 12, i32 7, i32 147, i32 169, i32 115, i32 131,
	i32 122, i32 84, i32 51, i32 70, i32 54, i32 66, i32 6, i32 125,
	i32 130, i32 132, i32 52, i32 116, i32 19, i32 91, i32 41, i32 164,
	i32 140, i32 60, i32 118, i32 132, i32 71, i32 4, i32 135, i32 31,
	i32 58, i32 29, i32 142, i32 86, i32 159, i32 10, i32 48, i32 129,
	i32 0, i32 157, i32 64, i32 99, i32 123, i32 146, i32 83, i32 75,
	i32 152, i32 76, i32 133, i32 36, i32 28, i32 38
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

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
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ a618557d1fa38074e0256317fb17c1baee245a79"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
