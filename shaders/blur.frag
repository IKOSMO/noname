#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uMaxBlur;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    
    // Вычисляем нормализованную позицию Y (от 0 внизу до 1 вверху)
    float normalizedY = fragCoord.y / uSize.y;
    
    // Градиент размытия: сильное внизу (normalizedY = 0), слабое вверху (normalizedY = 1)
    float blurAmount = (1.0 - normalizedY) * uMaxBlur;
    
    // Применяем размытие через множественную выборку пикселей
    vec4 color = vec4(0.0);
    float total = 0.0;
    
    // Количество итераций для качества (больше = лучше, но медленнее)
    int samples = 16;
    
    for (int i = 0; i < samples; i++) {
        for (int j = 0; j < samples; j++) {
            float offsetX = (float(i) / float(samples) - 0.5) * blurAmount * 2.0;
            float offsetY = (float(j) / float(samples) - 0.5) * blurAmount * 2.0;
            
            vec2 sampleCoord = fragCoord + vec2(offsetX, offsetY);
            sampleCoord = clamp(sampleCoord, vec2(0.0), uSize);
            
            color += texture(uTexture, sampleCoord / uSize);
            total += 1.0;
        }
    }
    
    fragColor = color / total;
}