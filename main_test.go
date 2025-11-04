package main

import (
	"testing"
)

func TestServiceStructure(t *testing.T) {
	// Test that services array is properly initialized
	if len(services) != 4 {
		t.Errorf("Expected 4 services, got %d", len(services))
	}

	// Test service names
	expectedNames := []string{"Apache", "MongoDB", "MySQL", "Memcached"}
	for i, service := range services {
		if service.name != expectedNames[i] {
			t.Errorf("Expected service name %s, got %s", expectedNames[i], service.name)
		}
	}
}

func TestConfigurationsStructure(t *testing.T) {
	// Test that configurations array is properly initialized
	if len(configurations) != 5 {
		t.Errorf("Expected 5 configurations, got %d", len(configurations))
	}
}

func TestLogsStructure(t *testing.T) {
	// Test that logs array is properly initialized
	if len(logs) != 5 {
		t.Errorf("Expected 5 logs, got %d", len(logs))
	}
}

func TestToolsStructure(t *testing.T) {
	// Test that tools array is properly initialized
	if len(tools) != 5 {
		t.Errorf("Expected 5 tools, got %d", len(tools))
	}
}

func TestDocumentationsStructure(t *testing.T) {
	// Test that documentations array is properly initialized
	if len(documentations) != 6 {
		t.Errorf("Expected 6 documentations, got %d", len(documentations))
	}
}

func TestVersionInfo(t *testing.T) {
	// Test that version variables are defined
	if version == "" {
		t.Error("Version should not be empty")
	}
	if buildTime == "" {
		t.Error("Build time should not be empty")
	}
}