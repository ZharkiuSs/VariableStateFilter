/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "PluginProcessor.h"

//==============================================================================
/**
*/
class VariableStateFilter4AudioProcessorEditor  : public juce::AudioProcessorEditor
{
public:
    VariableStateFilter4AudioProcessorEditor (VariableStateFilter4AudioProcessor&, juce::AudioProcessorValueTreeState& vts);
    ~VariableStateFilter4AudioProcessorEditor() override;

    //==============================================================================
    void paint (juce::Graphics&) override;
    void resized() override;

private:
    // This reference is provided as a quick way for your editor to
    // access the processor object that created it.
    VariableStateFilter4AudioProcessor& audioProcessor;
    juce::Slider cutoffFrequencySlider;
    std::unique_ptr<juce::AudioProcessorValueTreeState::SliderAttachment>cutoffFrequencyAttachment;

    juce:: Label cutoffFrequencyLabel;

    juce::ToggleButton highpassButton;
    std::unique_ptr < juce::AudioProcessorValueTreeState::ButtonAttachment>highpassAttachment;
    juce::Label highpassButtonLabel;


    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (VariableStateFilter4AudioProcessorEditor)
};
