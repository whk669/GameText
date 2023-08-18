// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXUI/2D/Base_3D"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

        [Main(z1,_KEYWORD,on,off)]_Blend("Blend", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Src("BlendRGB_Src", Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Dst("BlendRGB_Dst", Float) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONRGB("Blend ON RGB", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Src("BlendA_Src", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Dst("BlendA_Dst", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONA("Blend ON A", Float) = 0
        [Main(z2,_KEYWORD,on,off)]_Noise_001("Noise_001", Float) = 0
        [Tex(z2)]_NoiseTex_001("NoiseTex_001", 2D) = "white" {}
        [Tex(z2)]_NoiseTex001_UVTillingOffset("NoiseTex001_UVTillingOffset", Vector) = (1,1,0,0)
        [Tex(z2)]_NoiseTex_001_Panner("NoiseTex_001_Panner", Vector) = (0,0,0,0)
        [Tex(z3)]_NoiseTex_001Power("NoiseTex_001Power", Float) = 1
        [Tex(z3)]_NoiseTex001_int("NoiseTex001_int", Float) = 1
        [Main(z3,_KEYWORD,on,off)]_Noise_002("Noise_002", Float) = 0
        [Tex(z3)]_NoiseTex_002("NoiseTex_002", 2D) = "white" {}
        [Tex(z3)]_NoiseTex_002_TillingOffset("NoiseTex_002_TillingOffset", Vector) = (1,1,0,0)
        [Tex(z3)]_NoiseTex_002_Panner("NoiseTex_002_Panner", Vector) = (0,0,0,0)
        [Tex(z3)]_NoiseTex002_Power("NoiseTex002_Power", Float) = 1
        [Tex(z3)]_NoiseTex002_int("NoiseTex002_int", Float) = 1
        [Main(z4,_KEYWORD,on,off)]_Mask("Mask", Float) = 0
        [Tex(z4)]_MaskTex("MaskTex", 2D) = "white" {}
        [Main(z5,_KEYWORD,on,off)]_MainColor_("MainColor_", Float) = 0
        [HDR][Tex(z5)]_MainColor("MainColor", Color) = (1,1,1,1)
        [Tex(z5)]_MainColor_Int("MainColor_Int", Float) = 1
        _Alpha("Alpha", Float) = 1
        [HideInInspector] _texcoord( "", 2D ) = "white" {}

    }

    SubShader
    {
		LOD 0

        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

        Stencil
        {
        	Ref [_Stencil]
        	ReadMask [_StencilReadMask]
        	WriteMask [_StencilWriteMask]
        	Comp [_StencilComp]
        	Pass [_StencilOp]
        }


        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        
        Pass
        {
            Name "Default"
        CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            #include "UnityShaderVariables.cginc"


            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                float4  mask : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
                
            };

            sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;
            float _UIMaskSoftnessX;
            float _UIMaskSoftnessY;

            uniform float _Mask;
            uniform float _Noise_002;
            uniform float _Noise_001;
            uniform float _MainColor_;
            uniform float _BlendA_Src;
            uniform float _BlendA_Dst;
            uniform float _BlendRGB_Dst;
            uniform float _BlendONRGB;
            uniform float _BlendONA;
            uniform float _BlendRGB_Src;
            uniform float _Blend;
            uniform sampler2D _NoiseTex_002;
            uniform float2 _NoiseTex_002_Panner;
            uniform float4 _NoiseTex_002_TillingOffset;
            uniform float _NoiseTex002_Power;
            uniform float _NoiseTex002_int;
            uniform sampler2D _NoiseTex_001;
            uniform float2 _NoiseTex_001_Panner;
            uniform float4 _NoiseTex001_UVTillingOffset;
            uniform float _NoiseTex_001Power;
            uniform float _NoiseTex001_int;
            uniform sampler2D _MaskTex;
            uniform float4 _MaskTex_ST;
            uniform float _Alpha;
            uniform float4 _MainColor;
            uniform float _MainColor_Int;

            
            v2f vert(appdata_t v )
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                

                v.vertex.xyz +=  float3( 0, 0, 0 ) ;

                float4 vPosition = UnityObjectToClipPos(v.vertex);
                OUT.worldPosition = v.vertex;
                OUT.vertex = vPosition;

                float2 pixelSize = vPosition.w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));

                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                OUT.texcoord = v.texcoord;
                OUT.mask = float4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN ) : SV_Target
            {
                //Round up the alpha color coming from the interpolator (to 1.0/256.0 steps)
                //The incoming alpha could have numerical instability, which makes it very sensible to
                //HDR color transparency blend, when it blends with the world's texture.
                const half alphaPrecision = half(0xff);
                const half invAlphaPrecision = half(1.0/alphaPrecision);
                IN.color.a = round(IN.color.a * alphaPrecision)*invAlphaPrecision;

                float2 texCoord231 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 temp_output_225_0 = (texCoord231*2.0 + -1.0);
                float2 break227 = temp_output_225_0;
                float2 appendResult230 = (float2(length( temp_output_225_0 ) , (0.0 + (atan2( break227.y , break227.x ) - 0.0) * (1.0 - 0.0) / (3.141593 - 0.0))));
                float2 UV263 = appendResult230;
                float2 appendResult257 = (float2(_NoiseTex_002_TillingOffset.x , _NoiseTex_002_TillingOffset.y));
                float2 appendResult258 = (float2(_NoiseTex_002_TillingOffset.z , _NoiseTex_002_TillingOffset.w));
                float2 panner259 = ( 1.0 * _Time.y * _NoiseTex_002_Panner + (UV263*appendResult257 + appendResult258));
                float4 temp_cast_0 = (_NoiseTex002_Power).xxxx;
                float4 Noise002271 = ( pow( tex2D( _NoiseTex_002, panner259 ) , temp_cast_0 ) * _NoiseTex002_int );
                float2 appendResult249 = (float2(_NoiseTex001_UVTillingOffset.x , _NoiseTex001_UVTillingOffset.y));
                float2 appendResult248 = (float2(_NoiseTex001_UVTillingOffset.z , _NoiseTex001_UVTillingOffset.w));
                float2 panner201 = ( 1.0 * _Time.y * _NoiseTex_001_Panner + (UV263*appendResult249 + appendResult248));
                float4 temp_cast_1 = (_NoiseTex_001Power).xxxx;
                float4 Noise001268 = ( pow( tex2D( _NoiseTex_001, panner201 ) , temp_cast_1 ) * _NoiseTex001_int );
                float2 uv_MaskTex = IN.texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
                float4 appendResult198 = (float4(( (Noise002271).rgb * (Noise001268).rgb ) , ( ( ( (Noise001268).r * (Noise002271).r ) * tex2D( _MaskTex, uv_MaskTex ).a ) * _Alpha )));
                

                half4 color = ( appendResult198 * _MainColor * _MainColor_Int );

                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                color.a *= m.x * m.y;
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                color.rgb *= color.a;

                return color;
            }
        ENDCG
        }
    }
    CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19108
Node;AmplifyShaderEditor.CommentaryNode;276;2335.326,-505.0268;Inherit;False;538;341;Comment;2;246;277;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;270;-1812.908,54.85812;Inherit;False;2088.386;415.9504;Comment;14;280;275;251;260;256;271;259;255;258;257;264;281;286;287;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;269;-1816.202,-420.6388;Inherit;False;2094.324;421.3406;Comment;14;268;283;282;192;274;202;250;201;247;248;249;265;284;285;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;266;-1428.665,-838.3134;Inherit;False;1355.148;356.6044;极坐标;8;228;229;226;227;225;231;230;263;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;189;2787.553,-1480.898;Inherit;False;852;373;Comment;7;261;219;220;191;204;203;190;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;2719.507,-821.6656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;254;2733.216,-963.267;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ATan2OpNode;228;-766.6386,-686.7089;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;229;-629.6385,-688.7089;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.141593;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;226;-887.6386,-784.7089;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;227;-893.6386,-685.7089;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ScaleAndOffsetNode;225;-1148.639,-784.7089;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;231;-1378.665,-783.8779;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;230;-434.3747,-784.7089;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;263;-297.5171,-788.3133;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-1686.202,-338.2625;Inherit;False;263;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;249;-1503.248,-217.7398;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;248;-1384.155,-166.298;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;247;-1268.249,-334.7401;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;201;-849.745,-331.9221;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;-1687.908,155.0361;Inherit;False;263;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;257;-1500.958,258.8086;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;258;-1370.517,306.8085;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;255;-1239.958,154.8085;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;259;-819.9586,155.8085;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;199;2405.645,-937.7657;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;267;2213.103,-937.8991;Inherit;False;268;Noise001;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;252;2067.654,-966.7174;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;200;2411.329,-831.498;Inherit;False;FLOAT;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;273;2084.958,-799.9777;Inherit;False;FLOAT;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;213;1786.106,-606.6656;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;245;2880.989,-815.4786;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;250;-1788.252,-245.7397;Inherit;False;Property;_NoiseTex001_UVTillingOffset;NoiseTex001_UVTillingOffset;9;0;Create;True;0;0;0;False;2;Tex(z2);;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;202;-1083.746,-313.9221;Inherit;False;Property;_NoiseTex_001_Panner;NoiseTex_001_Panner;10;0;Create;True;0;0;0;False;1;Tex(z2);False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector4Node;256;-1747.506,231.8083;Inherit;False;Property;_NoiseTex_002_TillingOffset;NoiseTex_002_TillingOffset;15;0;Create;True;0;0;0;False;1;Tex(z3);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;2545.507,-666.6656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;210;2404.507,-646.6656;Inherit;False;Property;_Mask_Int;Mask_Int;22;0;Create;True;0;0;0;False;0;False;5;7.61;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;211;1827.106,-665.6656;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;215;2255.106,-664.6656;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;207;1593.548,-713.6656;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;1980.548,-666.6656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;2106.106,-644.6656;Inherit;False;Property;_Mask_Power;Mask_Power;21;0;Create;True;0;0;0;False;0;False;1;1.28;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;277;2725.537,-357.8634;Inherit;False;Property;_Mask;Mask;19;0;Create;True;0;0;0;True;1;Main(z4,_KEYWORD,on,off);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;246;2385.326,-453.8493;Inherit;True;Property;_MaskTex;MaskTex;20;0;Create;True;0;0;0;False;2;Tex(z4);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;272;1870.958,-967.9777;Inherit;False;271;Noise002;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;271;58.93195,122.0424;Inherit;False;Noise002;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;275;81.63336,211.809;Inherit;False;Property;_Noise_002;Noise_002;13;0;Create;True;0;0;0;True;3;;Main(z3,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;251;-630.522,125.8582;Inherit;True;Property;_NoiseTex_002;NoiseTex_002;14;0;Create;True;0;0;0;False;2;Tex(z3);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;260;-1060.958,175.8084;Inherit;False;Property;_NoiseTex_002_Panner;NoiseTex_002_Panner;16;0;Create;True;0;0;0;False;2;Tex(z3);;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;280;-81.27788,128.9844;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;268;76.20895,-359.8835;Inherit;False;Noise001;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;282;-61.10038,-354.3435;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;274;104.5657,-260.9088;Inherit;False;Property;_Noise_001;Noise_001;7;0;Create;True;0;0;0;True;3;;Main(z2,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;284;-238.2478,-355.653;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;192;-653.7454,-361.9221;Inherit;True;Property;_NoiseTex_001;NoiseTex_001;8;0;Create;True;0;0;0;False;1;Tex(z2);False;-1;None;18c93521f8f68ad40a2cdbffd0fd678c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;283;-105.2536,-261.329;Inherit;False;Property;_NoiseTex001_int;NoiseTex001_int;12;0;Create;True;0;0;0;False;1;Tex(z3);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;-351.6265,-252.2214;Inherit;False;Property;_NoiseTex_001Power;NoiseTex_001Power;11;0;Create;True;0;0;0;False;2;Tex(z3);;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;287;-249.6265,127.7786;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;281;-120.2056,234.9998;Inherit;False;Property;_NoiseTex002_int;NoiseTex002_int;18;0;Create;True;0;0;0;False;1;Tex(z3);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;-338.6265,231.7786;Inherit;False;Property;_NoiseTex002_Power;NoiseTex002_Power;17;0;Create;True;0;0;0;False;1;Tex(z3);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;198;3281.382,-962.4826;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;217;3410.171,-943.9492;Inherit;False;Property;_MainColor;MainColor;24;1;[HDR];Create;True;0;0;0;False;1;Tex(z5);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;3774.171,-961.9492;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;288;3612.343,-919.7312;Inherit;False;Property;_MainColor_Int;MainColor_Int;25;0;Create;True;0;0;0;False;2;Tex(z5);;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;222;4153.373,-962.9583;Float;False;True;-1;2;ASEMaterialInspector;0;3;VFXUI/2D/Base_3D;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;True;2;5;False;;10;False;;0;5;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.RangedFloatNode;279;3792.538,-783.3615;Inherit;False;Property;_MainColor_;MainColor_;23;0;Create;True;0;0;0;True;1;Main(z5,_KEYWORD,on,off);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;3153.206,-818.8851;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;3013.099,-800.2881;Inherit;False;Property;_Alpha;Alpha;26;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;3228.384,-1432.105;Inherit;False;Property;_BlendA_Src;BlendA_Src;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;3229.384,-1351.105;Inherit;False;Property;_BlendA_Dst;BlendA_Dst;5;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;2968.553,-1348.898;Inherit;False;Property;_BlendRGB_Dst;BlendRGB_Dst;2;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;2965.173,-1257.572;Inherit;False;Property;_BlendONRGB;Blend ON RGB;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;220;3230.173,-1260.572;Inherit;False;Property;_BlendONA;Blend ON A;6;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;2968.553,-1430.898;Inherit;False;Property;_BlendRGB_Src;BlendRGB_Src;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;;;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;261;2816.303,-1430.277;Inherit;False;Property;_Blend;Blend;0;0;Create;True;0;0;0;True;2;Main(z1,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
WireConnection;221;0;200;0
WireConnection;221;1;273;0
WireConnection;254;0;252;0
WireConnection;254;1;199;0
WireConnection;228;0;227;1
WireConnection;228;1;227;0
WireConnection;229;0;228;0
WireConnection;226;0;225;0
WireConnection;227;0;225;0
WireConnection;225;0;231;0
WireConnection;230;0;226;0
WireConnection;230;1;229;0
WireConnection;263;0;230;0
WireConnection;249;0;250;1
WireConnection;249;1;250;2
WireConnection;248;0;250;3
WireConnection;248;1;250;4
WireConnection;247;0;265;0
WireConnection;247;1;249;0
WireConnection;247;2;248;0
WireConnection;201;0;247;0
WireConnection;201;2;202;0
WireConnection;257;0;256;1
WireConnection;257;1;256;2
WireConnection;258;0;256;3
WireConnection;258;1;256;4
WireConnection;255;0;264;0
WireConnection;255;1;257;0
WireConnection;255;2;258;0
WireConnection;259;0;255;0
WireConnection;259;2;260;0
WireConnection;199;0;267;0
WireConnection;252;0;272;0
WireConnection;200;0;267;0
WireConnection;273;0;272;0
WireConnection;213;0;207;2
WireConnection;245;0;221;0
WireConnection;245;1;246;4
WireConnection;209;0;215;0
WireConnection;209;1;210;0
WireConnection;211;0;207;2
WireConnection;215;0;212;0
WireConnection;215;1;216;0
WireConnection;212;0;211;0
WireConnection;212;1;213;0
WireConnection;271;0;280;0
WireConnection;251;1;259;0
WireConnection;280;0;287;0
WireConnection;280;1;281;0
WireConnection;268;0;282;0
WireConnection;282;0;284;0
WireConnection;282;1;283;0
WireConnection;284;0;192;0
WireConnection;284;1;285;0
WireConnection;192;1;201;0
WireConnection;287;0;251;0
WireConnection;287;1;286;0
WireConnection;198;0;254;0
WireConnection;198;3;291;0
WireConnection;218;0;198;0
WireConnection;218;1;217;0
WireConnection;218;2;288;0
WireConnection;222;0;218;0
WireConnection;291;0;245;0
WireConnection;291;1;292;0
ASEEND*/
//CHKSM=32B7B13FAB7CEE174C5C856A0BEDA80AE981ADEA