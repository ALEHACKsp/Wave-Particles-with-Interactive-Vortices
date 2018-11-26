#include "GlobalInclude.hlsli"

WAVE_PARTICLE main(VS_INPUT input)
{
    WAVE_PARTICLE output;

    float2 pos = float2(input.pos.xy);
    float2 direction = input.texCoord;
    float height = input.pos.z;
    float radius = radiusScale * input.nor.x;
    float beta = input.nor.y;
    float speed = speedScale * input.nor.z;
    

    pos = pos + speed * timeScale * float(time) * direction;

    float2 posTemp = abs(pos);
    
    if (posTemp.x > 1.0 || posTemp.y > 1.0)
    {
        float2 offset = float2(0, 0);
        int2 posI = posTemp;
        float2 posF = posTemp - posI;

        if (posTemp.x > 1.0)
        {
            offset.x = (posI.x - 1) % 2 + posF.x;
            pos.x = sign(pos.x) * offset.x + sign(pos.x) * -1;
        }
    
        if (posTemp.y > 1.0)
        {
            offset.y = (posI.y - 1) % 2 + posF.y;
            pos.y = sign(pos.y) * offset.y + sign(pos.y) * -1;
        }
    }
    
    output.pos = float4(pos, 0.5, 1.0);
    output.direction = direction;
    output.height = height;
    output.radius = radius;
    output.beta = beta;
    output.speed = speed;

    return output;
}
