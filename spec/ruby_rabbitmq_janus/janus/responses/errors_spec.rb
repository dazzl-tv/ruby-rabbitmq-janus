# frozen_string_literal: true

require 'spec_helper'

describe RubyRabbitmqJanus::Janus::Responses::Errors, type: :responses,
                                                      name: :errors do
  let(:message) do
    {
      'janus' => 'error',
      'error' => {
        'code' => number,
        'reason' => reason
      }
    }
  end
  let(:response) { RubyRabbitmqJanus::Janus::Responses::Response.new(message) }
  let(:error) { described_class.new }
  let(:reason) { [*('a'..'z'), *('0'..'9')].sample(12).join }

  context 'when 403' do
    let(:number) { 403 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Unauthorized) }
  end

  context 'when 405' do
    let(:number) { 405 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::UnauthorizedPlugin) }
  end

  context 'when 450' do
    let(:number) { 450 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::TransportSpecific) }
  end

  context 'when 452' do
    let(:number) { 452 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::MissingRequest) }
  end

  context 'when 453' do
    let(:number) { 453 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::UnknownRequest) }
  end

  context 'when 454' do
    let(:number) { 454 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::InvalidJSON) }
  end

  context 'when 455' do
    let(:number) { 455 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::InvalidJSONObject) }
  end

  context 'when 456' do
    let(:number) { 456 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::MissingMandatoryElement) }
  end

  context 'when 457' do
    let(:number) { 457 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath) }
  end

  context 'when 458' do
    let(:number) { 458 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::SessionNotFound) }
  end

  context 'when 459' do
    let(:number) { 459 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::HandleNotFound) }
  end

  context 'when 460' do
    let(:number) { 460 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::PluginNotFound) }
  end

  context 'when 461' do
    let(:number) { 461 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::PluginAttach) }
  end

  context 'when 462' do
    let(:number) { 462 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::PluginMessage) }
  end

  context 'when 463' do
    let(:number) { 463 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::PluginDetach) }
  end

  context 'when 464' do
    let(:number) { 464 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::JSEPUnknownType) }
  end

  context 'when 465' do
    let(:number) { 465 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::JSEPInvalidSDP) }
  end

  context 'when 466' do
    let(:number) { 466 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::TrickleInvalidStream) }
  end

  context 'when 467' do
    let(:number) { 467 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType) }
  end

  context 'when 468' do
    let(:number) { 468 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::SessionConflit) }
  end

  context 'when 469' do
    let(:number) { 469 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::UnexpectedAnswer) }
  end

  context 'when 470' do
    let(:number) { 470 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::TokenNotFound) }
  end

  context 'when 471' do
    let(:number) { 471 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::WebRTCState) }
  end

  context 'when 472' do
    let(:number) { 472 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::NotAcceptingSession) }
  end

  context 'when 490' do
    let(:number) { 490 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Unknown) }
  end

  context 'when error missing' do
    let(:number) { 418 }

    it { expect{ error.send(:"_#{number}", response) }.to raise_error(RubyRabbitmqJanus::Errors::Janus::Responses::Nok) }
  end
end
