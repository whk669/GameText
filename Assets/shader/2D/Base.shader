// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXUI/2D/BaseKAnim"
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
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Src1("BlendRGB_Src", Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Dst1("BlendRGB_Dst", Float) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONRGB("Blend ON RGB", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Src("BlendA_Src", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Dst("BlendA_Dst", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONA("Blend ON A", Float) = 0
        _Total_Int("Total_Int", Float) = 1
        [HDR]_MainColor("MainColor", Color) = (1,1,1,1)
        [Main(z2,_KEYWORD,on,off)]_Main("Main", Float) = 0
        [Sub(z2)]_MainTex_PowerInt("MainTex_PowerInt", Vector) = (1,1,0,0)
        [Main(z7,_KEYWORD,on,off)]_Disturbance001("Disturbance001", Float) = 0
        [Tex(z7)]_DisturbanceTex001("DisturbanceTex001", 2D) = "white" {}
        [Tex(z7)]_DisturbanceTex001_TilingOffset("DisturbanceTex001_Tiling&Offset", Vector) = (1,1,0,0)
        [Tex(z7)]_DisturbanceTex001_RotationSpeed("DisturbanceTex001_RotationSpeed", Vector) = (0,0,0,0)
        [Tex(z7)]_DisturbanceTex001_PannerSpeed("DisturbanceTex001_PannerSpeed", Vector) = (0,0,1,0)
        [Tex(z7)]_DisturbanceTex001_PowerMul("DisturbanceTex001_Power&Mul", Vector) = (1,0,0,0)
        [Main(z3,_KEYWORD,on,off)]_Noise_001("Noise_001", Float) = 0
        [Tex(z3)]_NoiseTex001("NoiseTex001", 2D) = "white" {}
        [Sub(z3)]_NoiseTex001_TilingOffset("NoiseTex001_Tiling&Offset", Vector) = (1,1,0,0)
        [Sub(z3)]_NoiseTex_001PannerSpeed("NoiseTex_001PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z3)]_NoiseTex001_PowerMul("NoiseTex001_Power&Mul", Vector) = (1,1,0,0)
        [Sub(z3)]_NoiseTex001_LerPRorA("NoiseTex001_LerPRorA", Range( 0 , 1)) = 1
        [Main(z8,_KEYWORD,on,off)]_Disturbance002("Disturbance002", Float) = 0
        [Tex(z7)]_DisturbanceTex002("DisturbanceTex002", 2D) = "white" {}
        [Tex(z8)]_DisturbanceTex002_TilingOffset("DisturbanceTex002_Tiling&Offset", Vector) = (1,1,0,0)
        [Tex(z8)]_DisturbanceTex002_RotationSpeed("DisturbanceTex002_RotationSpeed", Vector) = (0,0,0,0)
        [Tex(z8)]_DisturbanceTex002_PannerSpeed("DisturbanceTex002_PannerSpeed", Vector) = (0,0,1,0)
        [Tex(z8)]_DisturbanceTex002_PowerMul("DisturbanceTex002_Power&Mul", Vector) = (1,0,0,0)
        [Main(z4,_KEYWORD,on,off)]_Noise_002("Noise_002", Float) = 0
        [Tex(z4)]_NoiseTex002("NoiseTex002", 2D) = "white" {}
        [Sub(z4)]_NoiseTex002_TilingOffset("NoiseTex002_Tiling&Offset", Vector) = (1,1,0,0)
        [Sub(z4)]_NoiseTex_002PannerSpeed("NoiseTex_002PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z4)]_NoiseTex002_PowerMul("NoiseTex002_Power&Mul", Vector) = (1,1,0,0)
        [Sub(z4)]_NoiseTex002_LerPRorA("NoiseTex002_LerPRorA", Range( 0 , 1)) = 1
        [Main(z5,_KEYWORD,on,off)]_MaskTex_001("MaskTex_001", Float) = 0
        [Tex(z5)]_MaskTex001("MaskTex001", 2D) = "white" {}
        [Sub(z5)]_MaskTex001_Tiling("MaskTex001_Tiling", Vector) = (1,1,0,0)
        [Sub(z5)]_MaskTex001_OffsetU("MaskTex001_OffsetU", Float) = 0
        [Sub(z5)]_MaskTex001_OffsetV("MaskTex001_OffsetV", Float) = 0
        [Sub(z5)]_MaskTex001_RotationSpeed("MaskTex001_RotationSpeed", Vector) = (0,0,0,0)
        [Sub(z5)]_MaskTex001_PannerSpeed("MaskTex001_PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z5)]_MaskTex001_Add("MaskTex001_Add", Float) = 0
        [Sub(z5)]_MaskTex001_PowerMul("MaskTex001_Power&Mul", Vector) = (1,1,0,0)
        [Sub(z5)]_MaskTex001_LerPRorA("MaskTex001_LerPRorA", Range( 0 , 1)) = 1
        [Main(z6,_KEYWORD,on,off)]_MaskTex_002("MaskTex_002", Float) = 0
        [Tex(z6)]_MaskTex002("MaskTex002", 2D) = "white" {}
        [Tex(z6)]_MaskTex002_Tiling("MaskTex002_Tiling", Vector) = (1,1,0,0)
        [Tex(z6)]_MaskTex002_OffsetU("MaskTex002_OffsetU", Float) = 0
        [Tex(z6)]_MaskTex002_OffsetV("MaskTex002_OffsetV", Float) = 0
        [Tex(z6)]_MaskTex002_RotationSpeed("MaskTex002_RotationSpeed", Vector) = (0,0,0,0)
        [Tex(z6)]_MaskTex002_PannerSpeed("MaskTex002_PannerSpeed", Vector) = (0,0,1,0)
        [Tex(z6)]_MaskTex002_Add("MaskTex002_Add", Float) = 0
        [Tex(z6)]_MaskTex002_PowerMul("MaskTex002_Power&Mul", Vector) = (1,1,0,0)
        [Sub(z6)]_MaskTex002_LerPRorA("MaskTex002_LerPRorA", Range( 0 , 1)) = 1
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
        Blend [_BlendRGB_Src1] [_BlendRGB_Dst1]
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
            #define ASE_NEEDS_FRAG_COLOR


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

            uniform float _BlendA_Src;
            uniform float _BlendA_Dst;
            uniform float _BlendRGB_Dst1;
            uniform float _BlendONRGB;
            uniform float _BlendONA;
            uniform float _BlendRGB_Src1;
            uniform float _Blend;
            uniform float _Main;
            uniform float _Noise_001;
            uniform float _Noise_002;
            uniform float _MaskTex_001;
            uniform float _MaskTex002_LerPRorA;
            uniform float _MaskTex_002;
            uniform float _Disturbance002;
            uniform float _Disturbance001;
            uniform float2 _MainTex_PowerInt;
            uniform sampler2D _NoiseTex001;
            uniform float4 _NoiseTex_001PannerSpeed;
            uniform float4 _NoiseTex001_TilingOffset;
            uniform sampler2D _DisturbanceTex001;
            uniform float4 _DisturbanceTex001_PannerSpeed;
            uniform float4 _DisturbanceTex001_TilingOffset;
            uniform float4 _DisturbanceTex001_RotationSpeed;
            uniform float2 _DisturbanceTex001_PowerMul;
            uniform float2 _NoiseTex001_PowerMul;
            uniform sampler2D _NoiseTex002;
            uniform float4 _NoiseTex_002PannerSpeed;
            uniform float4 _NoiseTex002_TilingOffset;
            uniform sampler2D _DisturbanceTex002;
            uniform float4 _DisturbanceTex002_PannerSpeed;
            uniform float4 _DisturbanceTex002_TilingOffset;
            uniform float4 _DisturbanceTex002_RotationSpeed;
            uniform float2 _DisturbanceTex002_PowerMul;
            uniform float2 _NoiseTex002_PowerMul;
            uniform sampler2D _MaskTex001;
            uniform float4 _MaskTex001_PannerSpeed;
            uniform float _MaskTex001_OffsetU;
            uniform float4 _MaskTex001_Tiling;
            uniform float _MaskTex001_OffsetV;
            uniform float4 _MaskTex001_RotationSpeed;
            uniform float _MaskTex001_Add;
            uniform float2 _MaskTex001_PowerMul;
            uniform sampler2D _MaskTex002;
            uniform float4 _MaskTex002_PannerSpeed;
            uniform float _MaskTex002_OffsetU;
            uniform float4 _MaskTex002_Tiling;
            uniform float _MaskTex002_OffsetV;
            uniform float4 _MaskTex002_RotationSpeed;
            uniform float _MaskTex002_Add;
            uniform float2 _MaskTex002_PowerMul;
            uniform float _NoiseTex001_LerPRorA;
            uniform float _NoiseTex002_LerPRorA;
            uniform float _MaskTex001_LerPRorA;
            uniform float _Total_Int;
            uniform float4 _MainColor;

            
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

                float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                float4 temp_cast_1 = (_MainTex_PowerInt.x).xxxx;
                float4 break100 = ( pow( tex2D( _MainTex, uv_MainTex ) , temp_cast_1 ) * _MainTex_PowerInt.y );
                float3 appendResult101 = (float3(break100.x , break100.y , break100.z));
                float3 MainTex_RGB45 = appendResult101;
                float4 break12_g63 = _NoiseTex_001PannerSpeed;
                float mulTime11_g63 = _Time.y * break12_g63.z;
                float2 appendResult13_g63 = (float2(break12_g63.x , break12_g63.y));
                float2 texCoord111 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g64 = (float2(( ( texCoord111.x + _NoiseTex001_TilingOffset.z ) * _NoiseTex001_TilingOffset.x ) , ( ( texCoord111.y + _NoiseTex001_TilingOffset.w ) * _NoiseTex001_TilingOffset.y )));
                float2 temp_output_76_0 = appendResult11_g64;
                float2 panner6_g63 = ( ( mulTime11_g63 + break12_g63.w ) * appendResult13_g63 + temp_output_76_0);
                float4 break12_g72 = _DisturbanceTex001_PannerSpeed;
                float mulTime11_g72 = _Time.y * break12_g72.z;
                float2 appendResult13_g72 = (float2(break12_g72.x , break12_g72.y));
                float2 texCoord329 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g73 = (float2(( ( texCoord329.x + _DisturbanceTex001_TilingOffset.z ) * _DisturbanceTex001_TilingOffset.x ) , ( ( texCoord329.y + _DisturbanceTex001_TilingOffset.w ) * _DisturbanceTex001_TilingOffset.y )));
                float4 break3_g74 = _DisturbanceTex001_RotationSpeed;
                float2 appendResult2_g74 = (float2(break3_g74.x , break3_g74.y));
                float mulTime5_g74 = _Time.y * break3_g74.z;
                float cos12_g74 = cos( ( mulTime5_g74 + break3_g74.w ) );
                float sin12_g74 = sin( ( mulTime5_g74 + break3_g74.w ) );
                float2 rotator12_g74 = mul( appendResult11_g73 - appendResult2_g74 , float2x2( cos12_g74 , -sin12_g74 , sin12_g74 , cos12_g74 )) + appendResult2_g74;
                float2 panner6_g72 = ( ( mulTime11_g72 + break12_g72.w ) * appendResult13_g72 + rotator12_g74);
                float4 temp_cast_3 = (_DisturbanceTex001_PowerMul.x).xxxx;
                float4 temp_cast_5 = (_NoiseTex001_PowerMul.x).xxxx;
                float4 temp_output_127_0 = ( pow( tex2D( _NoiseTex001, ( panner6_g63 + ( pow( tex2D( _DisturbanceTex001, panner6_g72 ) , temp_cast_3 ) * _DisturbanceTex001_PowerMul.y ).x ) ) , temp_cast_5 ) * _NoiseTex001_PowerMul.y );
                float3 temp_output_12_0 = (temp_output_127_0).xyz;
                float3 NoiseTex001_RGB40 = temp_output_12_0;
                float4 break12_g80 = _NoiseTex_002PannerSpeed;
                float mulTime11_g80 = _Time.y * break12_g80.z;
                float2 appendResult13_g80 = (float2(break12_g80.x , break12_g80.y));
                float2 texCoord117 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g81 = (float2(( ( texCoord117.x + _NoiseTex002_TilingOffset.z ) * _NoiseTex002_TilingOffset.x ) , ( ( texCoord117.y + _NoiseTex002_TilingOffset.w ) * _NoiseTex002_TilingOffset.y )));
                float2 temp_output_116_0 = appendResult11_g81;
                float2 panner6_g80 = ( ( mulTime11_g80 + break12_g80.w ) * appendResult13_g80 + temp_output_116_0);
                float4 break12_g76 = _DisturbanceTex002_PannerSpeed;
                float mulTime11_g76 = _Time.y * break12_g76.z;
                float2 appendResult13_g76 = (float2(break12_g76.x , break12_g76.y));
                float2 texCoord345 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g77 = (float2(( ( texCoord345.x + _DisturbanceTex002_TilingOffset.z ) * _DisturbanceTex002_TilingOffset.x ) , ( ( texCoord345.y + _DisturbanceTex002_TilingOffset.w ) * _DisturbanceTex002_TilingOffset.y )));
                float4 break3_g78 = _DisturbanceTex002_RotationSpeed;
                float2 appendResult2_g78 = (float2(break3_g78.x , break3_g78.y));
                float mulTime5_g78 = _Time.y * break3_g78.z;
                float cos12_g78 = cos( ( mulTime5_g78 + break3_g78.w ) );
                float sin12_g78 = sin( ( mulTime5_g78 + break3_g78.w ) );
                float2 rotator12_g78 = mul( appendResult11_g77 - appendResult2_g78 , float2x2( cos12_g78 , -sin12_g78 , sin12_g78 , cos12_g78 )) + appendResult2_g78;
                float2 panner6_g76 = ( ( mulTime11_g76 + break12_g76.w ) * appendResult13_g76 + rotator12_g78);
                float4 temp_cast_7 = (_DisturbanceTex002_PowerMul.x).xxxx;
                float4 temp_cast_9 = (_NoiseTex002_PowerMul.x).xxxx;
                float4 temp_output_131_0 = ( pow( tex2D( _NoiseTex002, ( panner6_g80 + ( pow( tex2D( _DisturbanceTex002, panner6_g76 ) , temp_cast_7 ) * _DisturbanceTex002_PowerMul.y ).x ) ) , temp_cast_9 ) * _NoiseTex002_PowerMul.y );
                float3 temp_output_114_0 = (temp_output_131_0).xyz;
                float3 NoiseTex002_RGB125 = temp_output_114_0;
                float4 break12_g49 = _MaskTex001_PannerSpeed;
                float mulTime11_g49 = _Time.y * break12_g49.z;
                float2 appendResult13_g49 = (float2(break12_g49.x , break12_g49.y));
                float2 texCoord176 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g46 = (float2(( ( texCoord176.x + _MaskTex001_OffsetU ) * _MaskTex001_Tiling.x ) , ( ( texCoord176.y + _MaskTex001_OffsetV ) * _MaskTex001_Tiling.y )));
                float4 break3_g47 = _MaskTex001_RotationSpeed;
                float2 appendResult2_g47 = (float2(break3_g47.x , break3_g47.y));
                float mulTime5_g47 = _Time.y * break3_g47.z;
                float cos12_g47 = cos( ( mulTime5_g47 + break3_g47.w ) );
                float sin12_g47 = sin( ( mulTime5_g47 + break3_g47.w ) );
                float2 rotator12_g47 = mul( appendResult11_g46 - appendResult2_g47 , float2x2( cos12_g47 , -sin12_g47 , sin12_g47 , cos12_g47 )) + appendResult2_g47;
                float2 panner6_g49 = ( ( mulTime11_g49 + break12_g49.w ) * appendResult13_g49 + rotator12_g47);
                float4 temp_cast_11 = (_MaskTex001_PowerMul.x).xxxx;
                float4 temp_output_182_0 = ( pow( saturate( ( tex2D( _MaskTex001, panner6_g49 ) + _MaskTex001_Add ) ) , temp_cast_11 ) * _MaskTex001_PowerMul.y );
                float3 temp_output_181_0 = (temp_output_182_0).xyz;
                float3 MaskTex001_RGB186 = temp_output_181_0;
                float4 break12_g61 = _MaskTex002_PannerSpeed;
                float mulTime11_g61 = _Time.y * break12_g61.z;
                float2 appendResult13_g61 = (float2(break12_g61.x , break12_g61.y));
                float2 texCoord237 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g59 = (float2(( ( texCoord237.x + _MaskTex002_OffsetU ) * _MaskTex002_Tiling.x ) , ( ( texCoord237.y + _MaskTex002_OffsetV ) * _MaskTex002_Tiling.y )));
                float4 break3_g60 = _MaskTex002_RotationSpeed;
                float2 appendResult2_g60 = (float2(break3_g60.x , break3_g60.y));
                float mulTime5_g60 = _Time.y * break3_g60.z;
                float cos12_g60 = cos( ( mulTime5_g60 + break3_g60.w ) );
                float sin12_g60 = sin( ( mulTime5_g60 + break3_g60.w ) );
                float2 rotator12_g60 = mul( appendResult11_g59 - appendResult2_g60 , float2x2( cos12_g60 , -sin12_g60 , sin12_g60 , cos12_g60 )) + appendResult2_g60;
                float2 panner6_g61 = ( ( mulTime11_g61 + break12_g61.w ) * appendResult13_g61 + rotator12_g60);
                float4 temp_cast_13 = (_MaskTex002_PowerMul.x).xxxx;
                float4 temp_output_251_0 = ( pow( saturate( ( tex2D( _MaskTex002, panner6_g61 ) + _MaskTex002_Add ) ) , temp_cast_13 ) * _MaskTex002_PowerMul.y );
                float3 temp_output_248_0 = (temp_output_251_0).xyz;
                float3 MaskTex002_RGB247 = temp_output_248_0;
                float MainTex_A46 = break100.w;
                float lerpResult258 = lerp( temp_output_12_0.x , (temp_output_127_0).w , _NoiseTex001_LerPRorA);
                float NoiseTex001_A41 = lerpResult258;
                float lerpResult262 = lerp( temp_output_114_0.x , (temp_output_131_0).x , _NoiseTex002_LerPRorA);
                float NoiseTex002_A124 = lerpResult262;
                float lerpResult265 = lerp( temp_output_181_0.x , (temp_output_182_0).w , _MaskTex001_LerPRorA);
                float MaskTex001_A185 = lerpResult265;
                float temp_output_250_0 = (temp_output_251_0).w;
                float MaskTex002_A249 = temp_output_250_0;
                float4 appendResult21 = (float4(( MainTex_RGB45 * NoiseTex001_RGB40 * NoiseTex002_RGB125 * MaskTex001_RGB186 * MaskTex002_RGB247 ) , ( MainTex_A46 * NoiseTex001_A41 * NoiseTex002_A124 * MaskTex001_A185 * MaskTex002_A249 )));
                float4 Main77 = saturate( appendResult21 );
                

                half4 color = ( Main77 * _Total_Int * IN.color * _MainColor );

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
Node;AmplifyShaderEditor.CommentaryNode;336;-6296.83,129.9851;Inherit;False;2009.366;570.6436;Comment;12;339;330;326;338;340;333;331;332;329;328;327;358;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;188;-4308.742,1433.201;Inherit;False;3134.654;581.3235;Comment;23;266;265;264;183;185;186;192;191;193;184;182;181;189;187;173;190;179;180;174;178;177;176;175;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;79;-1165.138,-56.94111;Inherit;False;1694.187;661.8237;Comment;15;44;42;77;65;43;47;4;21;72;132;133;168;169;170;171;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;49;-4147.769,127.9656;Inherit;False;2957.926;555.1154;Comment;20;108;36;109;110;111;76;106;325;260;258;257;128;41;24;11;40;127;104;12;341;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;48;-3147.986,-256.7325;Inherit;False;1734.295;298.1684;Comment;9;3;46;1;45;98;100;101;102;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;60;1283.173,12.89762;Float;False;True;-1;2;ASEMaterialInspector;0;3;VFXUI/2D/BaseKAnim;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;True;3;1;True;_BlendRGB_Src1;10;True;_BlendRGB_Dst1;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1134.981,12.19754;Inherit;False;4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;63;832.9807,62.19749;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-444.2795,5.310295;Inherit;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;80;835.4281,-453.7308;Inherit;False;852;373;Comment;7;87;86;85;84;83;82;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;654.4683,5.71463;Inherit;False;77;Main;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-3117.203,-199.5566;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-1634.16,-200.2093;Inherit;False;MainTex_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;100;-2032.091,-195.2614;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;101;-1817.091,-195.2614;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;98;-2305.714,-197.2153;Inherit;False;Power_int;-1;;31;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-1633.749,-124.9885;Inherit;False;MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-2556.67,-57.36127;Inherit;False;Property;_Main;Main;11;0;Create;True;0;0;0;True;2;Main(z2,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;112;-4160.237,761.6625;Inherit;False;2973.548;581.888;Comment;19;263;130;262;261;124;113;122;125;131;114;123;119;120;118;117;116;115;121;355;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;126;1060.746,153.8431;Inherit;False;Property;_MainColor;MainColor;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;12;-1831.202,225.7875;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-2780.523,465.6826;Inherit;False;Property;_Noise_001;Noise_001;19;0;Create;True;0;0;0;True;2;Main(z3,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-1624.808,229.1345;Inherit;False;NoiseTex001_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-869.1379,2.058898;Inherit;False;45;MainTex_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-1086.785,50.83264;Inherit;False;125;NoiseTex002_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-681.9941,24.14351;Inherit;False;40;NoiseTex001_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;102;-2549.091,-203.2614;Inherit;False;Property;_MainTex_PowerInt;MainTex_PowerInt;12;0;Create;True;0;0;0;False;1;Sub(z2);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;3;-2952.752,-203.3374;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;121;-2707.052,864.4845;Inherit;True;Property;_NoiseTex002;NoiseTex002;33;0;Create;True;0;0;0;False;2;Tex(z4);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;168;-881.9146,78.06525;Inherit;False;186;MaskTex001_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;114;-1893.048,866.4845;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;131;-2131.181,868.8663;Inherit;False;Power_int;-1;;43;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-1627.655,863.8315;Inherit;False;NoiseTex002_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-2783.369,1099.38;Inherit;False;Property;_Noise_002;Noise_002;32;0;Create;True;0;0;0;True;2;Main(z4,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;983.9807,33.1975;Inherit;False;Property;_Total_Int;Total_Int;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;194;-4366.065,2198.237;Inherit;False;3203.007;583.4595;Comment;23;249;274;273;250;252;247;241;245;246;243;242;239;255;244;254;253;251;248;240;238;237;236;276;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;175;-3552.238,1590.718;Inherit;False;UV;-1;;46;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;176;-3802.963,1483.201;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;177;-3323.652,1587.889;Inherit;False;Rotation;1;;47;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.Vector4Node;178;-3629.508,1780.844;Inherit;False;Property;_MaskTex001_RotationSpeed;MaskTex001_RotationSpeed;44;0;Create;True;0;0;0;False;2;Sub(z5);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;174;-3034.217,1587.889;Inherit;False;Panner;-1;;49;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;180;-3302.126,1686.39;Inherit;False;Property;_MaskTex001_PannerSpeed;MaskTex001_PannerSpeed;45;0;Create;True;0;0;0;False;2;Sub(z5);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;179;-3821.742,1607.691;Inherit;False;Property;_MaskTex001_Tiling;MaskTex001_Tiling;41;0;Create;True;0;0;0;False;1;Sub(z5);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;190;-4041.583,1699.727;Inherit;False;Property;_MaskTex001_OffsetV;MaskTex001_OffsetV;43;0;Create;True;0;0;0;False;2;Sub(z5);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;173;-2716.281,1541.272;Inherit;True;Property;_MaskTex001;MaskTex001;40;0;Create;True;0;0;0;False;2;Tex(z5);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;187;-2789.526,1783.412;Inherit;False;Property;_MaskTex_001;MaskTex_001;39;0;Create;True;0;0;0;True;2;Main(z5,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-4248.583,1675.727;Inherit;False;Property;_MaskTex001_OffsetU;MaskTex001_OffsetU;42;0;Create;True;0;0;0;False;2;Sub(z5);;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;181;-1763.221,1543.113;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;182;-2008.354,1554.495;Inherit;False;Power_int;-1;;50;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;193;-2146.168,1554.977;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;-2316.168,1548.977;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-2386.168,1648.977;Inherit;False;Property;_MaskTex001_Add;MaskTex001_Add;46;0;Create;True;0;0;0;False;1;Sub(z5);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;-1623.777,1544.482;Inherit;False;MaskTex001_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;113;-1887.049,962.4841;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;183;-1763.222,1653.113;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-825.3445,250.8826;Inherit;False;41;NoiseTex001_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-644.085,230.3782;Inherit;False;46;MainTex_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1012.785,279.8326;Inherit;False;124;NoiseTex002_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-661.9146,302.0652;Inherit;False;185;MaskTex001_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-836.9146,331.0652;Inherit;False;249;MaskTex002_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-216.5006,6.653091;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;72;-74.82401,7.298807;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;57.04865,3.257637;Inherit;False;Main;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;-680.9146,97.0652;Inherit;False;247;MaskTex002_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-454.0328,235.2988;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;24;-1826.203,323.7872;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-1370.808,302.1346;Inherit;False;NoiseTex001_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;257;-1638.123,304.8536;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;258;-1516.123,304.8536;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-1891.123,420.8536;Inherit;False;Property;_NoiseTex001_LerPRorA;NoiseTex001_LerPRorA;25;0;Create;True;0;0;0;False;2;Sub(z3);;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-1435.655,934.8315;Inherit;False;NoiseTex002_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;261;-1715.682,939.3752;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;262;-1593.682,939.3752;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-1357.794,1628.122;Inherit;False;MaskTex001_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;130;-2372.181,862.8663;Inherit;False;Property;_NoiseTex002_PowerMul;NoiseTex002_Power&Mul;37;0;Create;True;0;0;0;False;1;Sub(z4);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;263;-1959.614,1055.307;Inherit;False;Property;_NoiseTex002_LerPRorA;NoiseTex002_LerPRorA;38;0;Create;True;0;0;0;False;2;Sub(z4);;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;184;-2015.354,1663.427;Inherit;False;Property;_MaskTex001_PowerMul;MaskTex001_Power&Mul;47;0;Create;True;0;0;0;False;1;Sub(z5);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;264;-1620.673,1631.261;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;265;-1507.217,1632.329;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-1771.689,1772.825;Inherit;False;Property;_MaskTex001_LerPRorA;MaskTex001_LerPRorA;48;0;Create;True;0;0;0;False;2;Sub(z5);;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;236;-3628.965,2399.643;Inherit;False;UV;-1;;59;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;237;-3879.689,2292.126;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;238;-3400.379,2396.814;Inherit;False;Rotation;1;;60;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.FunctionNode;240;-3110.944,2396.814;Inherit;False;Panner;-1;;61;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;248;-1839.948,2352.038;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;251;-2085.081,2363.42;Inherit;False;Power_int;-1;;62;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;253;-2222.895,2363.902;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;254;-2392.895,2357.902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;244;-2793.008,2350.197;Inherit;True;Property;_MaskTex002;MaskTex002;50;0;Create;True;0;0;0;False;2;Tex(z6);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;242;-3898.469,2416.616;Inherit;False;Property;_MaskTex002_Tiling;MaskTex002_Tiling;51;0;Create;True;0;0;0;False;1;Tex(z6);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;243;-4118.309,2508.652;Inherit;False;Property;_MaskTex002_OffsetV;MaskTex002_OffsetV;53;0;Create;True;0;0;0;False;2;Tex(z6);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;246;-4325.31,2484.652;Inherit;False;Property;_MaskTex002_OffsetU;MaskTex002_OffsetU;52;0;Create;True;0;0;0;False;2;Tex(z6);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;247;-1699.504,2353.407;Inherit;False;MaskTex002_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;250;-1839.949,2462.038;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;249;-1367.238,2438.114;Inherit;False;MaskTex002_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;273;-1686.535,2437.605;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;274;-1573.079,2438.673;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-2461.766,2457.902;Inherit;False;Property;_MaskTex002_Add;MaskTex002_Add;56;0;Create;True;0;0;0;False;1;Tex(z6);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;241;-3377.724,2495.315;Inherit;False;Property;_MaskTex002_PannerSpeed;MaskTex002_PannerSpeed;55;0;Create;True;0;0;0;False;2;Tex(z6);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;239;-3705.105,2588.64;Inherit;False;Property;_MaskTex002_RotationSpeed;MaskTex002_RotationSpeed;54;0;Create;True;0;0;0;False;2;Tex(z6);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;325;-2878.534,262.9243;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;106;-3229.431,264.5001;Inherit;False;Panner;-1;;63;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;76;-3747.451,267.3291;Inherit;False;UV;-1;;64;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;111;-3998.176,159.8118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;110;-3498.34,364.0568;Inherit;False;Property;_NoiseTex_001PannerSpeed;NoiseTex_001PannerSpeed;23;0;Create;True;0;0;0;False;2;Sub(z3);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;36;-4013.171,285.3022;Inherit;False;Property;_NoiseTex001_TilingOffset;NoiseTex001_Tiling&Offset;21;0;Create;True;0;0;0;False;1;Sub(z3);False;1,1,0,0;1,1,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;108;-3523.866,268.5002;Inherit;False;Rotation;1;;65;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.RangedFloatNode;276;-1846.21,2573.383;Inherit;False;Property;_MaskTex002_LerPRorA;MaskTex002_LerPRorA;58;0;Create;True;0;0;0;True;2;Sub(z6);;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;252;-2344.952,2550.291;Inherit;False;Property;_MaskTex002_PowerMul;MaskTex002_Power&Mul;57;0;Create;True;0;0;0;False;1;Tex(z6);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;245;-2861.737,2593.466;Inherit;False;Property;_MaskTex_002;MaskTex_002;49;0;Create;True;0;0;0;True;2;Main(z6,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-2704.206,230.7875;Inherit;True;Property;_NoiseTex001;NoiseTex001;20;0;Create;True;0;0;0;False;2;Tex(z3);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;109;-3824.682,457.4553;Inherit;False;Property;_NoiseTex_001RotationSpeed;NoiseTex_001RotationSpeed;22;0;Create;True;0;0;0;False;2;Sub(z3);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;127;-2130.254,230.8431;Inherit;False;Power_int;-1;;66;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;128;-2388.254,231.0536;Inherit;False;Property;_NoiseTex001_PowerMul;NoiseTex001_Power&Mul;24;0;Create;True;0;0;0;False;1;Sub(z3);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;341;-4115.903,308.7718;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;327;-5463.09,284.6733;Inherit;False;Panner;-1;;72;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;328;-5981.11,287.5024;Inherit;False;UV;-1;;73;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;329;-6231.835,179.9851;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;332;-6246.83,305.4755;Inherit;False;Property;_DisturbanceTex001_TilingOffset;DisturbanceTex001_Tiling&Offset;15;0;Create;True;0;0;0;False;1;Tex(z7);False;1,1,0,0;1,1,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;331;-6058.341,477.6287;Inherit;False;Property;_DisturbanceTex001_RotationSpeed;DisturbanceTex001_RotationSpeed;16;0;Create;True;0;0;0;False;2;Tex(z7);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;333;-5756.438,283.2449;Inherit;False;Rotation;1;;74;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.FunctionNode;338;-4813.85,283.6601;Inherit;False;Power_int;-1;;75;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;330;-5732,384.2302;Inherit;False;Property;_DisturbanceTex001_PannerSpeed;DisturbanceTex001_PannerSpeed;17;0;Create;True;0;0;0;False;2;Tex(z7);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;340;-4505.566,282.5938;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;342;-6301.007,808.9731;Inherit;False;2009.366;570.6436;Comment;12;354;353;352;351;350;349;348;347;346;345;344;343;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;343;-5467.267,963.6613;Inherit;False;Panner;-1;;76;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;344;-5985.287,966.4904;Inherit;False;UV;-1;;77;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;345;-6236.012,858.9731;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;348;-5760.615,962.2329;Inherit;False;Rotation;1;;78;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.FunctionNode;349;-4818.027,962.6481;Inherit;False;Power_int;-1;;79;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;354;-4509.743,961.5818;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;115;-3266.902,902.012;Inherit;False;Panner;-1;;80;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;116;-3784.923,904.8411;Inherit;False;UV;-1;;81;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-4035.648,797.3238;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;118;-3556.337,902.0123;Inherit;False;Rotation;1;;82;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.Vector4Node;120;-3862.193,1094.967;Inherit;False;Property;_NoiseTex_002RotationSpeed;NoiseTex_002RotationSpeed;35;0;Create;True;0;0;0;False;2;Sub(z4);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;119;-4054.427,922.8143;Inherit;False;Property;_NoiseTex002_TilingOffset;NoiseTex002_Tiling&Offset;34;0;Create;True;0;0;0;False;1;Sub(z4);False;1,1,0,0;0,0,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;123;-3535.811,1000.513;Inherit;False;Property;_NoiseTex_002PannerSpeed;NoiseTex_002PannerSpeed;36;0;Create;True;0;0;0;False;2;Sub(z4);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;346;-6251.007,984.4635;Inherit;False;Property;_DisturbanceTex002_TilingOffset;DisturbanceTex002_Tiling&Offset;28;0;Create;True;0;0;0;False;1;Tex(z8);False;1,1,0,0;1,1,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;347;-6062.518,1157.617;Inherit;False;Property;_DisturbanceTex002_RotationSpeed;DisturbanceTex002_RotationSpeed;29;0;Create;True;0;0;0;False;2;Tex(z8);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;352;-5735.177,1063.218;Inherit;False;Property;_DisturbanceTex002_PannerSpeed;DisturbanceTex002_PannerSpeed;30;0;Create;True;0;0;0;False;2;Tex(z8);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;351;-5183.248,935.7838;Inherit;True;Property;_DisturbanceTex002;DisturbanceTex002;27;0;Create;True;0;0;0;False;2;Tex(z7);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;339;-4865.563,416.3261;Inherit;False;Property;_DisturbanceTex001_PowerMul;DisturbanceTex001_Power&Mul;18;0;Create;True;0;0;0;False;1;Tex(z7);False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;326;-5180.071,256.7958;Inherit;True;Property;_DisturbanceTex001;DisturbanceTex001;14;0;Create;True;0;0;0;False;2;Tex(z7);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;353;-4869.74,1095.314;Inherit;False;Property;_DisturbanceTex002_PowerMul;DisturbanceTex002_Power&Mul;31;0;Create;True;0;0;0;False;1;Tex(z8);False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;350;-5116.467,1137.22;Inherit;False;Property;_Disturbance002;Disturbance002;26;0;Create;True;0;0;0;True;2;Main(z8,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;358;-5169.983,493.3778;Inherit;False;Property;_Disturbance001;Disturbance001;13;0;Create;True;0;0;0;True;1;Main(z7,_KEYWORD,on,off);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;355;-2886.855,898.0655;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;81;1274.259,-404.9379;Inherit;False;Property;_BlendA_Src;BlendA_Src;6;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;1275.259,-323.9379;Inherit;False;Property;_BlendA_Dst;BlendA_Dst;7;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;1014.428,-321.7308;Inherit;False;Property;_BlendRGB_Dst1;BlendRGB_Dst;4;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;1011.048,-230.4049;Inherit;False;Property;_BlendONRGB;Blend ON RGB;5;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;1276.048,-233.4049;Inherit;False;Property;_BlendONA;Blend ON A;8;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;1014.428,-403.7308;Inherit;False;Property;_BlendRGB_Src1;BlendRGB_Src;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;;;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;862.1781,-403.1099;Inherit;False;Property;_Blend;Blend;0;0;Create;True;0;0;0;True;2;Main(z1,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
WireConnection;60;0;61;0
WireConnection;61;0;78;0
WireConnection;61;1;62;0
WireConnection;61;2;63;0
WireConnection;61;3;126;0
WireConnection;4;0;44;0
WireConnection;4;1;42;0
WireConnection;4;2;132;0
WireConnection;4;3;168;0
WireConnection;4;4;169;0
WireConnection;45;0;101;0
WireConnection;100;0;98;0
WireConnection;101;0;100;0
WireConnection;101;1;100;1
WireConnection;101;2;100;2
WireConnection;98;5;3;0
WireConnection;98;6;102;1
WireConnection;98;3;102;2
WireConnection;46;0;100;3
WireConnection;12;0;127;0
WireConnection;40;0;12;0
WireConnection;3;0;1;0
WireConnection;121;1;355;0
WireConnection;114;0;131;0
WireConnection;131;5;121;0
WireConnection;131;6;130;1
WireConnection;131;3;130;2
WireConnection;125;0;114;0
WireConnection;175;27;176;1
WireConnection;175;28;176;2
WireConnection;175;18;179;1
WireConnection;175;24;179;2
WireConnection;175;25;189;0
WireConnection;175;26;190;0
WireConnection;177;9;175;0
WireConnection;177;10;178;0
WireConnection;174;7;177;7
WireConnection;174;14;180;0
WireConnection;173;1;174;0
WireConnection;181;0;182;0
WireConnection;182;5;193;0
WireConnection;182;6;184;1
WireConnection;182;3;184;2
WireConnection;193;0;191;0
WireConnection;191;0;173;0
WireConnection;191;1;192;0
WireConnection;186;0;181;0
WireConnection;113;0;131;0
WireConnection;183;0;182;0
WireConnection;21;0;4;0
WireConnection;21;3;65;0
WireConnection;72;0;21;0
WireConnection;77;0;72;0
WireConnection;65;0;47;0
WireConnection;65;1;43;0
WireConnection;65;2;133;0
WireConnection;65;3;170;0
WireConnection;65;4;171;0
WireConnection;24;0;127;0
WireConnection;41;0;258;0
WireConnection;257;0;12;0
WireConnection;258;0;257;0
WireConnection;258;1;24;0
WireConnection;258;2;260;0
WireConnection;124;0;262;0
WireConnection;261;0;114;0
WireConnection;262;0;261;0
WireConnection;262;1;113;0
WireConnection;262;2;263;0
WireConnection;185;0;265;0
WireConnection;264;0;181;0
WireConnection;265;0;264;0
WireConnection;265;1;183;0
WireConnection;265;2;266;0
WireConnection;236;27;237;1
WireConnection;236;28;237;2
WireConnection;236;18;242;1
WireConnection;236;24;242;2
WireConnection;236;25;246;0
WireConnection;236;26;243;0
WireConnection;238;9;236;0
WireConnection;238;10;239;0
WireConnection;240;7;238;7
WireConnection;240;14;241;0
WireConnection;248;0;251;0
WireConnection;251;5;253;0
WireConnection;251;6;252;1
WireConnection;251;3;252;2
WireConnection;253;0;254;0
WireConnection;254;0;244;0
WireConnection;254;1;255;0
WireConnection;244;1;240;0
WireConnection;247;0;248;0
WireConnection;250;0;251;0
WireConnection;249;0;250;0
WireConnection;273;0;248;0
WireConnection;274;0;273;0
WireConnection;274;1;250;0
WireConnection;274;2;276;0
WireConnection;325;0;106;0
WireConnection;325;1;341;0
WireConnection;106;7;76;0
WireConnection;106;14;110;0
WireConnection;76;27;111;1
WireConnection;76;28;111;2
WireConnection;76;18;36;1
WireConnection;76;24;36;2
WireConnection;76;25;36;3
WireConnection;76;26;36;4
WireConnection;108;9;76;0
WireConnection;108;10;109;0
WireConnection;11;1;325;0
WireConnection;127;5;11;0
WireConnection;127;6;128;1
WireConnection;127;3;128;2
WireConnection;341;0;340;0
WireConnection;327;7;333;7
WireConnection;327;14;330;0
WireConnection;328;27;329;1
WireConnection;328;28;329;2
WireConnection;328;18;332;1
WireConnection;328;24;332;2
WireConnection;328;25;332;3
WireConnection;328;26;332;4
WireConnection;333;9;328;0
WireConnection;333;10;331;0
WireConnection;338;5;326;0
WireConnection;338;6;339;1
WireConnection;338;3;339;2
WireConnection;340;0;338;0
WireConnection;343;7;348;7
WireConnection;343;14;352;0
WireConnection;344;27;345;1
WireConnection;344;28;345;2
WireConnection;344;18;346;1
WireConnection;344;24;346;2
WireConnection;344;25;346;3
WireConnection;344;26;346;4
WireConnection;348;9;344;0
WireConnection;348;10;347;0
WireConnection;349;5;351;0
WireConnection;349;6;353;1
WireConnection;349;3;353;2
WireConnection;354;0;349;0
WireConnection;115;7;116;0
WireConnection;115;14;123;0
WireConnection;116;27;117;1
WireConnection;116;28;117;2
WireConnection;116;18;119;1
WireConnection;116;24;119;2
WireConnection;116;25;119;3
WireConnection;116;26;119;4
WireConnection;118;9;116;0
WireConnection;118;10;120;0
WireConnection;351;1;343;0
WireConnection;326;1;327;0
WireConnection;355;0;115;0
WireConnection;355;1;354;0
ASEEND*/
//CHKSM=50D2B6FB1F1118FE16DE99210011BD3D510670FA